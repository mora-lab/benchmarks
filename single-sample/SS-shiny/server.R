shinyServer(function(input, output, session){
  options(shiny.maxRequestSize=100*1024^2)
  
  source("global.R")
  ####################################################
  ###################   Input data   #################
  ####################################################
  expdata <- reactive({
    data = c()
    if(input$exp == "sf"){
      data = samplefile
    } else if(input$exp == "td"){
      cat("It's under building...Please wait!")
    } else if(input$exp == "browse" & !is.null(input$userdata)){
      data = readRDS(input$userdata$datapath)
    }
    return(data)
  })
  
  targetgs <- reactive({
    tardata = c()
    if(input$targetpath == "sf1"){
      tardata = sampleGS
    }
    if(input$targetpath == "td1"){
      cat("It's under building...Please wait!")
    }
    if(input$targetpath == "browse1" & !is.null(input$userdata1)){
      tardata = read_data(input$userdata1$datapath)
      #tardata = head(tardata)
    }
    return(tardata)
  })
  
  GSdata <- reactive({
    gsdata = list("KEGGpathlist" = msigKEGG, 
                  "KEGGGScollection" = KEGGgscollection)
    return(gsdata)
    
  })
  ####################################################
  #############  Output of Data Preview  #############
  ####################################################
  output$expTable <-  DT::renderDataTable(DT::datatable({
   expdata()[[1]]
  }))
  
  output$Target <- renderPrint({
    if(input$targetpath == "sf1"){
      targetgs()
    } else if(input$targetpath == "td1"){
      targetgs()[[1]]
    } else if(input$targetpath == "browse1" & !is.null(input$userdata1)){
      targetgs()[[1]]
    }
    
  })
  
  # runner <- observeEvent(input$submit,{resOutput()})
  ####################################################
  ################  Process Data   ###################
  ####################################################
  resOutput = eventReactive(input$submit, {
    t.res = list();
    p.res = list();
    score = list();
    pval.res = list();
    SSP.res = list();
    newSSP.res = list();
    temp2 = list();
    nsamplefile = expdata();
    nsampleGS = targetgs();
    temp2 = word(names(nsampleGS), 2, sep="\\.");
    for (i in 1:length(nsamplefile)){
      temp1 = list();
      t.res[[i]] = run_methods(nsamplefile[[i]],
                               pathway, 
                               GSEA.Methods = input$GSEAMethods,
                               pvalCombMethod =input$comp);
      p.res[[i]] = t.res[[i]]$summary.pvalue.result;
      score[[i]] = t.res[[i]]$score;
      pval.res[[i]] = t.res[[i]]$pvalue.result;
      names(pval.res)[i] = names(score)[i] = names(p.res)[i] = names(t.res)[i] = names(nsamplefile)[i];
      temp1 = word(names(nsamplefile)[[i]], 2, sep="\\.")
      t = nsampleGS[which(temp1 == temp2)]
      SSP.res[[i]] = SSP_calculation(p.res[[i]], t);  
      newSSP.res[[i]] = newSSPresult(SSP.res[[i]]);
      # colnames(newSSP.res[[i]]) = c("sen")
      newSSP.res[[i]]$Datasets = names(p.res)[[i]];
    }
    newSSP.result = do.call(rbind, newSSP.res);
    newSSP.result$Methods = gsub("PVAL.", "", toupper(newSSP.result$Methods))
    senplot = ggplot(newSSP.result, aes(Methods, sensitivity, fill = Methods))+ ## sensitivity
      geom_boxplot()+
      xlab("Methods")+
      ylab("Sensitivity")
    
    speplot = ggplot(newSSP.result, aes(Methods,specificity, fill = Methods))+  ## specificity
      geom_boxplot()+
      xlab("Methods")+
      ylab("Specificity")
    
    preplot = ggplot(newSSP.result, aes(Methods,precision, fill = Methods))+  ## precision
      geom_boxplot() +
      scale_y_sqrt()+
      xlab("Methods")+
      ylab("Precision")
    
    ROCdata = newSSP.result
    ROCdata$FPR = 1-ROCdata$specificity
    ROCdata = ROCdata[,c("Methods", "sensitivity", "FPR")]
    ROCdata = gather(ROCdata, "Type", "Value", -Methods)
    
    roc <- ggplot(ROCdata, aes(d = Type,m = Value, color = Methods))+ 
      geom_roc() + 
      style_roc(theme = theme_grey, xlab = "Specificity",ylab = "Sensitivity") + ggtitle("ROC") +
      ggsci::scale_color_lancet()
    
    result = list("score" = score,
                  "pvalue.result" = pval.res,
                  "SSP.result" = newSSP.result,
                  "ROC.result" = ROCdata,
                  "sensitivity.plot" = senplot,
                  "specificity.plot" = speplot,
                  "precision.plot" = preplot,
                  "ROC.plot" = roc)
    return(result)

  })
  
  ### Plots of Results
  output$result = renderPrint({
    if(!is.null(input$plot)){
      resOutput()$SSP.result
    }
    
  })
  output$cplot <- renderPlot({
    if(input$plot == "sn"){
      resOutput()$sensitivity.plot
    } else if(input$plot == "sp"){
      resOutput()$specificity.plot
    } else if(input$plot == "pr"){
      resOutput()$precision.plot
    } else if(input$plot == "roc"){
      resOutput()$ROC.plot
    }
  }) 
    
    
    ### Download
    output$downloadData <- downloadHandler(
      filename = function() { paste('result_', Sys.Date(), '.RData', sep='') },
      content = function(con) { save(resOutput, con)}
    )

})