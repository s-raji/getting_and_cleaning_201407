getting_and_cleaning_201407
===========================

Following are the step by step description of the scripts in run_analyis.R

1. Download the file to the working directory
2. Unzip the file
3. Read all data relevant to the train dataset- subject, X_train and Y_train each to a dataframe
4. Read all data relevant to the test dataset- subject, X_test and Y_test each to a dataframe
5. Read the column names and convert to a dataframe. The column names of the X_test and X-train are provided in the code book named feature.txt
6. Change the column names of the X dataframes to the relevant column names as per the code book
7. Extract only those columns that measures either the mean or standard deviation using sqldf
8. Extract the required columns from the X dataframes
9. Change the column names of the subject and Y datasets as well
10.Column bind the subject, X and Y datasets of the train dataset
11.Column bind the subject, X and Y datasets of the test dataset
12.Row bind the train and test datasets that were column binded in the prevoius steps
13.Change the activity names to descriptive activity names
14.Remove the dots, and short forms on the column names
15.Create a new dataset with the mean of all the columns by activity and by subject
16.Write the tidy merged dataset to a text file
