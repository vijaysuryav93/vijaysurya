
library("qdapRegex")
library(caret)
library(dplyr)
library(rio)
library(taRifx)

GC <- "All visitors_Sep_4_2020.xlsx"

library("qdapRegex")

adata_list <- import_list(GC)
off_page_surge_File <- adata_list$`Asset conversions`
dim(off_page_surge_File)
write.csv(off_page_surge_File,'off_page_surge_File.csv')
off_page_surge_File <- read.csv("off_page_surge_File.csv", header = T)
off_page_surge_File <- off_page_surge_File[-c(1)]
dim(off_page_surge_File)

#Renaming colummn
colnames(off_page_surge_File)[colnames(off_page_surge_File) == 'BusinessPhone'] <- 'Business.Phone'

#Adding origin
off_page_surge_File$origin <- "Asset conversions"
off_page_surge_File$origin <- as.factor(off_page_surge_File$origin)


#creating domain name from submitted mail id1
off_page_surge_File$Account.Domain <- sub('.*@','',off_page_surge_File$EmailAddress)

#Removing unnecessaru columns
drop <- c('X_REFERRER','X_FORM_URL','X_JSTZO','Privacy.Policy','First.Name','Last.Name','X_GEO_POSTAL_CODE',
          'X_BROWSER','X_IPADDR')
off_page_surge_File = off_page_surge_File[,!(names(off_page_surge_File) %in% drop)]


#Retaining needed column
offpage_surge_account_details <- off_page_surge_File[c('Submitted.Name','Submitted.Email','When',
                                                       'current_page_URL','FileName',
                                                       'X_FORM','X_CAMPAIGN','X_GEO_COUNTRY','X_GEO_STATE',
                                                       'X_GEO_CITY','Asset_Type',
                                                       'Account.Domain')]


dim(offpage_surge_account_details)

#converting data types
#offpage_surge_account_details$Industry <- as.factor(offpage_surge_account_details$Industry)

#Writing into a file
off_page_surge_File[is.na(off_page_surge_File)] = 0
write.csv(offpage_surge_account_details,'DUMP_asset_conversions.csv')
dim(offpage_surge_account_details)


############################################################################


VJ<- c("All visitors_Jan 6-12 2020.xlsx","All visitors_Jan 13 - Feb 2 2020.xlsx",
       "All visitors_Feb 3-9 2020.xlsx","All visitors_Feb 17-23 2020.xlsx",
       "All visitors_Feb 24-March 1 2020.xlsx",
       "All visitors_March 2-15 2020.xlsx",
       "All visitors_March 16-22 2020.xlsx","All visitors_March 23-29 2020.xlsx",
       "All visitors_March 30 - April 5 2020.xlsx",
       
       
       
       
       "All visitors_June 1-14 2020.xlsx","All visitors_June 15-21 2020.xlsx",
       "All visitors_June 22 - July 5 2020.xlsx","All visitors_July 6-12 2020.xlsx",
       "All visitors_July 13-19 2020.xlsx",
       "All visitors_July 27 - Aug 2 2020.xlsx", "All visitors_Aug 3-9 2020.xlsx",
       "All visitors_Aug 10-16 2020.xlsx", "All visitors_Aug 17-23 2020.xlsx",
       "All visitors_Aug 24-25 2020.xlsx", "All visitors_Aug 24 - 30 2020.xlsx"
)

for (GC in VJ) {
  
  print(GC)
  adata_list <- import_list(GC)
  off_page_surge_File <- adata_list$`Asset conversions`
  dim(off_page_surge_File)
  write.csv(off_page_surge_File,'off_page_surge_File.csv')
  off_page_surge_File <- read.csv("off_page_surge_File.csv", header = T)
  off_page_surge_File <- off_page_surge_File[-c(1)]
  dim(off_page_surge_File)
  
  #Renaming colummn
  colnames(off_page_surge_File)[colnames(off_page_surge_File) == 'BusinessPhone'] <- 'Business.Phone'
  
  #Adding origin
  off_page_surge_File$origin <- "Asset conversions"
  off_page_surge_File$origin <- as.factor(off_page_surge_File$origin)
  
  
  #creating domain name from submitted mail id1
  off_page_surge_File$Account.Domain <- sub('.*@','',off_page_surge_File$EmailAddress)
  
  #Removing unnecessaru columns
  drop <- c('X_REFERRER','X_FORM_URL','X_JSTZO','Privacy.Policy','First.Name','Last.Name','X_GEO_POSTAL_CODE',
            'X_BROWSER','X_IPADDR')
  off_page_surge_File = off_page_surge_File[,!(names(off_page_surge_File) %in% drop)]
  
  
  #Retaining needed column
  offpage_surge_account_details <- off_page_surge_File[c('Submitted.Name','Submitted.Email','When',
                                                         'current_page_URL','FileName',
                                                         'X_FORM','X_CAMPAIGN','X_GEO_COUNTRY','X_GEO_STATE',
                                                         'X_GEO_CITY','Asset_Type',
                                                         'Account.Domain')]
  
  
  dim(offpage_surge_account_details)
  
  #converting data types
  #offpage_surge_account_details$Industry <- as.factor(offpage_surge_account_details$Industry)
  
  #saving as dummy
  write.csv(offpage_surge_account_details,'dummy_details.csv')
  
  #Appending DUMP and Newdata for INFO
  dump_data_details <- read.csv("DUMP_asset_conversions.csv", header = T)
  dump_data_details <- dump_data_details[-c(1)]
  new_data <- read.csv("dummy_details.csv", header = T)
  new_data <- new_data[-c(1)]
  dim(new_data)
  dim(dump_data_details)
  
  new_details <- full_join(new_data, dump_data_details)
  dim(new_details)
  #new[is.na(new_details)] <- 0
  off_page_surge_File[is.na(off_page_surge_File)] = 0
  write.csv(new_details, "DUMP_asset_conversions.csv")
  dim(new_details)
  #warnings()
  
}


#For Verification
dump_data_details <- read.csv("DUMP_asset_conversions.csv", header = T)
dump_data_details <- dump_data_details[-c(1)]
dim(dump_data_details)

