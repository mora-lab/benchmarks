## Loading libraries.
library(shiny)
library(shinythemes)

## Main module.
ui = navbarPage("SS_Shiny",
                theme = shinythemes::shinytheme("cerulean"),  # <--- Specify theme here
                        
                tabPanel("Examples",
                         sidebarLayout(
                           sidebarPanel(
                             h3("Example Run"),
                             h5("Notice: Those tools('individPath', 'iPAS' and 'mogsa') are not ready."),
                             radioButtons(inputId = "d1", label = "Select a disease(target pathway/datasets)",
                                          choices = list("Asthma(GSE35571+GSE67472)"="Asthma", 
                                                         "COPD(GSE11906+GSE42057)"="COPD", 
                                                         "Non-small cells lung cancer(GSE10245+GSE18842)"="NSCLC", 
                                                         "Tuberculosis(GSE50834+GSE52819)"="Tuberculosis"),
                                          selected = "Asthma"),
                             radioButtons(inputId = "t1", label = "Select a tool",
                                          choices = list("ZSCORE"="ZSCORE", "PLAGE"="PLAGE", "SSGSEA"="SSGSEA", "GSVA"="GSVA",   
                                                         "pathifier"="pathifier", "GRAPE"="GRAPE",  "individPath"="individPath", 
                                                         "iPAS"="iPAS"),
                                          selected = "ZSCORE"),
                             helpText("Refer to Tarca et al. (https://doi.org/10.1371/journal.pone.0079217) we try the following four parameters to compare."),
                             selectInput(inputId = "m1", label = "Select a comparison parameter",
                                         choices = c("Sensitivity"="sn", "Specificity"="sp"), # "Prioritization"="pn", "Precision"="pr" 
                                         selected = "sn"),
                             actionButton(inputId = "submit", label="Submit", icon("fas fa-magic"))
                             ),
                           
                           mainPanel(
                             tabsetPanel( type = "tab",
                                          tabPanel("Preview of data", tableOutput(outputId = "table1")), # Show file contents.
                                          h4("Data Table"),
                                          tabPanel("Plots of Results",
                                                   conditionalPanel(condition = "input.m==sn", tags$img(src="Sensitivity.jpeg", 
                                                                                                        height="500", 
                                                                                                        width="1000",
                                                                                                        align="center")),
                                                   conditionalPanel(condition = "input.m==sp", tags$img(src="Specificity.jpeg",
                                                                                                        height="500", 
                                                                                                        width="1000",
                                                                                                        align="center")))
                                          )))),
                tabPanel("Data analysis", 
                         sidebarLayout(
                           sidebarPanel(
                             h4("Analyze user's data"),
                             p("Please input and choose:"),
                             fileInput(inputId = "bds", label = "Please upload expression data",
                                       accept = c("text/csv",
                                                  "tab/comma-separated-values,text/plain",
                                                  ".csv",
                                                  ".txt")),
                             fileInput(inputId = "bds", label = "Please upload phenotype data",
                                       accept = c("text/csv",
                                                  "tab/comma-separated-values,text/plain",
                                                  ".csv",
                                                  ".txt")),
                             radioButtons(inputId = "d2", label = "Select a disease(target pathway)",
                                          choices = list("Asthma"="Asthma", "COPD"="COPD", 
                                                         "Non-small cells lung cancer"="NSCLC", 
                                                         "Tuberculosis"="Tuberculosis"),
                                          selected = "Asthma"),
                             fileInput(inputId = "tp", label = "If there does not exist your target pathway or disease, please upload target pathway data:",
                                       accept = c("text/csv",
                                                  "tab/comma-separated-values,text/plain",
                                                  ".csv",
                                                  ".txt")),
                             radioButtons(inputId = "t2", label = "Select a tool",
                                          choices = list("ZSCORE"="ZSCORE", "PLAGE"="PLAGE", "SSGSEA"="SSGSEA", "GSVA"="GSVA",   
                                                         "pathifier"="pathifier", "GRAPE"="GRAPE",  "individPath"="individPath", 
                                                         "iPAS"="iPAS"),
                                          selected = "ZSCORE"),
                             actionButton(inputId = "submit", label="Submit", icon("fas fa-magic"))
                             ),
                           mainPanel(
                             tabsetPanel(type = "tab",
                                         tabPanel("Preview of datasets", tableOutput(outputId = "table2")), # Show file contents.
                                         tabPanel("Plots of Results",
                                                   conditionalPanel(condition = "input.m==sn", tags$img(src="Sensitivity.jpeg", 
                                                                                                        height="500", 
                                                                                                        width="1000",
                                                                                                        align="center")),
                                                   conditionalPanel(condition = "input.m==sp", tags$img(src="Specificity.jpeg",
                                                                                                        height="500", 
                                                                                                        width="1000",
                                                                                                        align="center"))),     # Display plot
                                         tabPanel("Download", "Download data"))))),
                tabPanel("Contact", 
                        h3("Please contact: "),
                        h4("Author: Chengshu(shuxcy@126.com)"),
                        h4("Group: Mora Lab(http://moralab.science/)")))


# Server logic 
server = function(input, output, session) {
  
  ## Display the contents of the table in the main panel.  
  output$table1 <- renderTable({
    if (is.null(input$d1))
      return(NULL)
    if(input$d1 == "Asthma") {
      head(read.table(input$d1$datapath, header = TRUE, sep = "\t", quote = ""))
      }
    
  })
  
  ## Display the summary of the table.
  output$summary <- renderPrint({
    summary(input$bds)
  })
  
  ## Aggregating plots from the radio button inputs from user- tool and disease.
  for_plot <- function(){
    
    
    if (!is.null(input$t) && !is.null(input$t)) ## Check for valid inputs
    {
      
      ## Import results for each metric from external, manually curated files.
      sensitivity_data <- read.table("WWW/Sensitivity_Table.txt", sep = "\t", header = TRUE, quote = "")
      specificity_data <- read.table("WWW/Specificity_Table.txt", sep = "\t", header = TRUE, quote = "")
      
      #### COPD	
      if(input$d == "COPD" && input$t == "GSVA")
      {
        db_sn <- sensitivity_data[,which(grepl("GSVA_COPD", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("GSVA_COPD", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp) 
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "COPD",
                xlab = "GSVA",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "COPD" && input$t == "SSGSEA")
      {
        db_sn <- sensitivity_data[,which(grepl("SSGSEA_COPD", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("SSGSEA_COPD", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "COPD",
                xlab = "SSGSEA",
                ylim = c(0,100))
        #                col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "COPD" && input$t == "PLAGE")
      {
        db_sn <- sensitivity_data[,which(grepl("PLAGE_COPD", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("PLAGE_COPD", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "COPD",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      
      if(input$d == "COPD" && input$t == "ZSCORE")
      {
        db_sn <- sensitivity_data[,which(grepl("ZSCORE_COPD", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("ZSCORE_COPD", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "COPD",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "COPD" && input$t == "pathifier" )
      {
        print( "Sorry, the results is running.....plsease wait the update news!")
      }
      if (input$d == "COPD" && input$t == "GRAPE" )
      { 
        print( "Sorry, the results is running.....plsease wait the update news!")
      }
      ## Asthma
      if(input$d == "Asthma" && input$t == "GSVA")
      {
        db_sn <- sensitivity_data[,which(grepl("GSVA_Asthma", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("GSVA_Asthma", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp) 
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Asthma",
                xlab = "GSVA",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "Asthma" && input$t == "SSGSEA")
      {
        db_sn <- sensitivity_data[,which(grepl("SSGSEA_Asthma", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("SSGSEA_Asthma", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Asthma",
                xlab = "SSGSEA",
                ylim = c(0,100))
        #                col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "Asthma" && input$t == "PLAGE")
      {
        db_sn <- sensitivity_data[,which(grepl("PLAGE_Asthma", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("PLAGE_Asthma", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Asthma",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      
      if(input$d == "Asthma" && input$t == "ZSCORE")
      {
        db_sn <- sensitivity_data[,which(grepl("ZSCORE_Asthma", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("ZSCORE_Asthma", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Asthma",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "Asthma" && input$t == "pathifier" )
      {
        print( "Sorry, the results is running.....plsease wait the update news!")
      }
      if (input$d == "Asthma" && input$t == "GRAPE" )
      {
        print( "Sorry, the results is running.....plsease wait the update news!")
      }  
      
      ## NSCLC
      if(input$d == "NSCLC" && input$t == "GSVA")
      {
        db_sn <- sensitivity_data[,which(grepl("GSVA_NSCLC", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("GSVA_NSCLC", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp) 
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "NSCLC",
                xlab = "GSVA",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "NSCLC" && input$t == "SSGSEA")
      {
        db_sn <- sensitivity_data[,which(grepl("SSGSEA_NSCLC", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("SSGSEA_NSCLC", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "NSCLC",
                xlab = "SSGSEA",
                ylim = c(0,100))
        #                col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "NSCLC" && input$t == "PLAGE")
      {
        db_sn <- sensitivity_data[,which(grepl("PLAGE_NSCLC", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("PLAGE_NSCLC", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "NSCLC",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      
      if(input$d == "NSCLC" && input$t == "ZSCORE")
      {
        db_sn <- sensitivity_data[,which(grepl("ZSCORE_NSCLC", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("ZSCORE_NSCLC", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "NSCLC",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "NSCLC" && input$t == "pathifier" )
      {
        print( "Sorry, the results is running.....plsease wait the update news!")
      }
      if(input$d == "NSCLC" && input$t == "GRAPE" )
      {
        print( "Sorry, the results is running.....plsease wait the update news!")
      }
      
      ## Tuberculosis
      if(input$d == "Tuberculosis" && input$t == "GSVA")
      {
        db_sn <- sensitivity_data[,which(grepl("GSVA_Tuberculosis", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("GSVA_Tuberculosis", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp) 
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Tuberculosis",
                xlab = "GSVA",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "Tuberculosis" && input$t == "SSGSEA")
      {
        db_sn <- sensitivity_data[,which(grepl("SSGSEA_Tuberculosis", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("SSGSEA_Tuberculosis", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Tuberculosis",
                xlab = "SSGSEA",
                ylim = c(0,100))
        #                col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "Tuberculosis" && input$t == "PLAGE")
      {
        db_sn <- sensitivity_data[,which(grepl("PLAGE_Tuberculosis", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("PLAGE_Tuberculosis", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Tuberculosis",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      
      if(input$d == "Tuberculosis" && input$t == "ZSCORE")
      {
        db_sn <- sensitivity_data[,which(grepl("ZSCORE_Tuberculosis", colnames(sensitivity_data)))]
        db_sp <- specificity_data[,which(grepl("ZSCORE_Tuberculosis", colnames(specificity_data)))]
        db <- cbind(db_sn,db_sp)
        boxplot(db,
                boxwex = 0.1,
                names = c("Sensitivity","Specificity"),
                ylab = "Tuberculosis",
                xlab = "PLAGE",
                ylim = c(0,100))
        #col = c("salmon","tan","khaki","lavender"))
        abline(h=50, col="red")
      }
      
      if(input$d == "Tuberculosis" && input$t == "pathifier" )
      {
        print( "Sorry, the results is running.....plsease wait the update news!")
      }
      if (input$d == "Tuberculosis" && input$t == "GRAPE")
      {
        print( "Sorry, the results is running.....plsease wait the update news!")
      }
      
    }
  }
  
  
  ## Deploying function for plotting at the click of the action button.
  
  output$table <- DT::renderDataTable({
    DT::datatable(cars)
  })
  
}

# Complete app with UI and server components
shinyApp(ui = ui, server = server)
