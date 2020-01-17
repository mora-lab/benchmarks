library(shiny)
library(shinythemes)

source("R/global.R") 
# source("R/run_individPath.R") 
# source("R/run_iPAS.R")
# source("R/run_individPath.R")
# options(shiny.maxRequestSize = 30*1024^2)


ui = navbarPage("SS_Shiny",
                theme = shinythemes::shinytheme("cerulean"),  # <--- Specify theme here
                
                ### Benchmark Study Results
                tabPanel("Benchmark Study",
                         sidebarLayout(
                           sidebarPanel(
                             h1("Results of SS_Benchmark"),
                             p(strong("Notice: In current results, there are some methods('individPath', 'iPAS' and 'GRAPE') not ready.")),
                             p(strong("In the benchmark study, we use 8 datasets of 4 respiratory diseases.")),
                             tags$hr(),
                             radioButtons("plot1", label = strong("Comparison plots"),
                                          choices = list("Sensitivity"="sn1",
                                                         "Specificity"="sp1", 
                                                         "Precision"="pr1",
                                                         "ROC plot"="ROC1",
                                                         "Plot all" = "allplots"), 
                                          selected = "sn1")
                           ),
                           
                           mainPanel(
                             tabPanel("Summary of Results",
                                      h2(strong("1. Datasets Overview")),
                                      tags$img(src="datasets.png",
                                               align="center"),
                                      h2(strong("2. Comparison Plots")),
                                      conditionalPanel("input.plot1 == 'allplots'", 
                                                       tags$img(src="allplots.jpeg", align="center", 
                                                                height = 1000, width = 1500),
                                                       p("Fig : A comparison of sensitivity, specificity, precision and ROC plot of 8 gene set analysis methods(bases on combined p.values).", align="center")),
                                      conditionalPanel("input.plot1 == 'sn1'", 
                                                       tags$img(src="Sensitivity.jpeg", align="center"),
                                                       p("Fig : A comparison of sensitivity ability of 8 gene set analysis methods(bases on combined p.values).")),
                                      conditionalPanel("input.plot1 == 'sp1'", 
                                                       tags$img(src="Specificity.jpeg", align="center"),
                                                       p("Fig : A comparison of specificity ability of 8 gene set analysis methods(bases on combined p.values).")),
                                      conditionalPanel("input.plot1 == 'pr1'", 
                                                       tags$img(src="Precision.jpeg", align="center"),
                                                       p("Fig : A comparison of precision ability of 8 gene set analysis methods(bases on combined p.values).")),
                                      conditionalPanel("input.plot1 == 'ROC1'", 
                                                       tags$img(src="ROC.jpeg", align="center"),
                                                       p("Fig : ROC plot of 8 gene set analysis methods(bases on combined p.values)."))
                             )))),
                
                ### Data analysis and comparison
                tabPanel("Data analysis", 
                         sidebarLayout(
                           sidebarPanel(
                             h1("Import and analyze user's data"),
                             strong(h3("Data preparation:")),
                             fileInput(inputId = "exp", label = "1. please upload your dataset(with gene symbols).: ",
                                       accept = c("text/csv",
                                                  "tab/comma-separated-values,text/plain",
                                                  ".csv",
                                                  ".txt")),
                             strong(p("Note that the first row is the sample names and the second row contains the information of '0/1(0 = Disease(Tumor), 1 = Normal(Control))'. The first column(except the 1st and 2rd row) stands for the information of gene symbols.")),
                             tags$hr(),
                             strong(p("2. Please select MSigDB files or upload your interested/target pathways or gene sets:")),
                             radioButtons("msigdb", label = strong("Select pathway files(note: the data in KEGG/Reactome/Biocarta are from MSigdb v7.0): "),
                                          choices = list("Ownfile(Uploaded)"="Own_file",
                                                         "KEGG" = "KEGG",
                                                         "Reactome"="Reactome",
                                                         "Biocarta"="Biocarta"), 
                                          selected = "Own_file"),
                             fileInput(inputId = "Ownfile", label = "Please upload your interested/target pathways or gene sets:",
                                       accept = c("text/csv",
                                                  "tab/comma-separated-values,text/plain",
                                                  ".csv",
                                                  ".txt",
                                                  ".gmt")
                             ),
                             tags$hr(),
                             strong(h3("Method selection:")),
                             
                             checkboxGroupInput(inputId = "GSEAMethods",
                                                label = "3. GSEA Methods",
                                                choices = c("plage",
                                                            "zscore",
                                                            "ssgsea",
                                                            "gsva",
                                                            "pathifier(This method need large amount of time)",
                                                            "individPath",
                                                            "GRAPE",
                                                            "iPAS"),
                                                selected = c("plage",
                                                             "zscore",
                                                             "ssgsea",
                                                             "gsva",
                                                             "pathifier",
                                                             "individPath",
                                                             "GRAPE",
                                                             "iPAS"),
                                                inline = FALSE, width = NULL, choiceNames = NULL, choiceValues = NULL ),
                             
                             tags$hr(),
                             radioButtons("comp", label = strong("4. Method to combine P-Values"),
                                          choices = list("sumlog((Fisher’s method)"="sumlog", 
                                                         "sumz(Stouffer’s method)" = "sumz",
                                                         "meanp" = "meanp"), 
                                          selected = "sumlog"),
                             tags$hr(),
                             radioButtons("plot2", label = strong("5. Comparison plots"),
                                          choices = list("Sensitivity"="sn2", 
                                                         "Specificity" = "sp2",
                                                         "Precision" = "pr2",
                                                         "ROC" = "ROC2"), 
                                          selected = "sumlog"),
                             tags$hr(),
                             actionButton(inputId = "submit", label="Submit", icon("fas fa-magic"))
                           ),
                           mainPanel(
                             tabsetPanel(type = "tab",
                                         tabPanel(h3("Preview of datasets"), 
                                                  # verbatimTextOutput("value"),
                                                  h4(strong("1. Expression Data Preview")),
                                                  DT::dataTableOutput("expTable"),
                                                  h4(strong("3. Genesets Data Preview(Only the head 6 shown here)")),
                                                  verbatimTextOutput("genesetsList")), # Show file contents.
                                         tabPanel(h3("Summary of Results"),
                                                  h4(strong("1. EnrichmentScores between MsigDB pathways and Samples")),
                                                  DT::dataTableOutput("EStable"),
                                                  h4(strong("2. P-Values of GeneSets(Refer to 'limma' package)")),
                                                  DT::dataTableOutput("GPtable"),
                                                  h4(strong("3. Combined P-Values(Refer to 'metap' package))")),
                                                  verbatimTextOutput("compvals")
                                                  
                                         ),     
                                         tabPanel(h3("Summary of Comparison Plots"),
                                                  conditionalPanel("input.plot2 == 'sn2'", 
                                                                   tags$img(src="Sensitivity.jpeg", align="center"),
                                                                   p("Fig : A comparison of sensitivity ability of 8 gene set analysis methods(bases on combined p.values).")),
                                                  conditionalPanel("input.plot2 == 'sp2'", 
                                                                   tags$img(src="Specificity.jpeg", align="center"),
                                                                   p("Fig : A comparison of specificity ability of 8 gene set analysis methods(bases on combined p.values).")),
                                                  conditionalPanel("input.plot2 == 'pr2'", 
                                                                   tags$img(src="Precision.jpeg", align="center"),
                                                                   p("Fig : A comparison of precision ability of 8 gene set analysis methods(bases on combined p.values).")),
                                                  conditionalPanel("input.plot2 == 'ROC2'", 
                                                                   tags$img(src="ROC.jpeg", align="center"),
                                                                   p("Fig : ROC plot of 8 gene set analysis methods(bases on combined p.values)."))
                                         ),     
                                         
                                         tabPanel(h3("Download"),          
                                                  downloadButton('downloadData', 'Download result table'),
                                                  p(" \n"),
                                                  downloadButton("report", "Generate report"),
                                                  p("Please wait while the report is generated, this might take a while... \n")
                                         )
                             )
                           )
                         )
                ),
                
                ### Contact
                tabPanel("Contact", 
                         h3("Please contact: "),
                         h4("Maintainer: Chengshu Xie(shuxcy@126.com)"),
                         h4("Group: Mora Lab(http://moralab.science/)")
                )
)




# Server logic 
server = function(input, output, session) {
  options(shiny.maxRequestSize=100*1024^2)
  ##########################
  ####     Reactive     ####
  ##########################
  expdata <- reactive({
    exp1 <- exp2 <- exp3 <- c() ;
    exp1 <- read_file(input$exp$datapath);
    exp2 <- format_input_pathifier(exp1);
    exp3 <- format_input_GRAPE(exp1);
    exp  <- list("gsva.input" = exp1, 
                 "pathifier.input" = exp2,
                 "GRAPE.input" = exp3,
                 "individPath.input" = exp3)
  })
  
  GSdata <- reactive({
    msigdb <- c();
    PATHWAYS <- list();
    GScollection <- c();
    if(input$msigdb == "KEGG"){
      msigdb <- msig_data[grep("KEGG", names(msig_data))]
      GScollection <- genesetcollection[grep("KEGG", genesetcollection)]
    }else if(input$msigdb == "Reactome"){
      msigdb <- msig_data[grep("REACTOME", names(msig_data))]
      GScollection <- genesetcollection[grep("KEGG", genesetcollection)]
    }else if(input$msigdb == "Biocarta"){
      msigdb <- msig_data[grep("BIOCARTA", names(msig_data))]
      GScollection <- genesetcollection[grep("KEGG", genesetcollection)]
    }else if(!is.null(input$Ownfile)){
      msigdb <- read_file(input$Ownfile$datapath)
      GScollection <- GSEABase::getGmt(input$Ownfile$datapath)
    }
    PATHWAYS$gs = msigdb;
    PATHWAYS$pathwaynames = as.list(names(msigdb));
    names(PATHWAYS$pathwaynames) = names(msigdb);
    gsdata = list("msigdb" = msigdb, "PATHWAYS" = PATHWAYS, "GScollection" = GScollection)
  })
  
  ### Output of Data Preview
  output$expTable <- DT::renderDataTable(DT::datatable({
    if(!is.null(input$exp))
      expdata()$gsva.input
  }))
  
  output$pheTable <- DT::renderDataTable(DT::datatable({
    if(!is.null(input$phe))
      phedata()
  }))
  
  output$genesetsList <- renderPrint({
    if((input$msigdb == "Own_file") & is.null(input$Ownfile)){ 
      cat("Please select the MSigDB data or upload genesets files!") 
    }
    head(GSdata()$msigdb)
  })
  
  ### Process Data 
  result_data <- reactive({
    # ESdata <- c();
    if (!is.null(input$exp) && !is.null(input$msigdb)) ## Check for valid inputs
    {
      ESdata.plage <- c();
      ESdata.zscore <- c();
      ESdata.gsva <- c();
      ESdata.ssgsea <- c();
      ESdata.pathifier <- c();
      # ESdata.GRAPE <- c();
      if(input$GSEAMethods == "plage" & input$GSEAMethods == "zscore" ){
        ESdata.plage <- GSVA::gsva(as.matrix(expdata()$gsva.input[-1,]), GSdata()$GScollection, method = "plage",
                             mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
      }
      if(input$GSEAMethods == "zscore"){
        ESdata.zscore <- GSVA::gsva(as.matrix(expdata()$gsva.input[-1,]), GSdata()$GScollection, method = "zscore", 
                             mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
      }
      if(input$GSEAMethods == "gsva"){
        ESdata.gsva <- GSVA::gsva(as.matrix(expdata()$gsva.input[-1,]), GSdata()$GScollection, method = "gsva", 
                             mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
      }
      if(input$GSEAMethods == "ssgsea"){
        ESdata.ssgsea <- GSVA::gsva(as.matrix(expdata()$gsva.input[-1,]), GSdata()$GScollection, method = "ssgsea", 
                             mx.diff = FALSE, parallel.sz=2, abs.ranking = FALSE, verbose=TRUE)
      }
      if(input$GSEAMethods == "ssgsea"){
        ESdata.pathifier <- run_pathifier(expdata()$pathifier.input, GSdata()$PATHWAYS)
      }}
      #     if(input$GSEAMethods == "pathifier"){
      #        ESdata <- run_pathifier(expdata, pathways)
      #     }
      #     if(input$GSEAMethods == "individPath"){
      #       ESdata <- run_individPath(expdata)
      #     }
      #     if(input$GSEAMethods == "GRAPE"){
      #       ESdata <- run_GRAPE(expdata)
      #     }
      #     if(input$GSEAMethods == "iPAS"){
      #       ESdata <- run_iPAS(expdata)
      #     }
    ESdata.all <- list("Plage.res" = ESdata.plage, "Zscore.res" = ESdata.zscore,
                       "GSVA.res" = ESdata.gsva, "ssGSEA.res" = ESdata.ssgsea,
                       "pathifier.res" = ESdata.pathifier)
    return(ESdata.all)
    })

### Summary of Results
output$EStable <- DT::renderDataTable(DT::datatable({
  
  if (input$GSEAMethods == "plage"){
    cat("You have chosen one method : 'plage'!")  
    result_data()$Plage.res
  }
  if (input$GSEAMethods == "plage" & input$GSEAMethods == "plage"){
    cat("You have chosen 'plage' method!")  
    result_data()$Plage.res
  }
  
  
  
  
})) 
### Plots of Results



}
  
  # Complete app with UI and server components
shinyApp(ui = ui, server = server)
  
