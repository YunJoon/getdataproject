CodeBook.md
==================
##run_analysis.R
<ol>
    <li>
        Step 0 : Reading tables from data
        <ol>
            <li>
                Step 0-1 : Read the "test" Folder
                <ul>
                    <li>subject_test : table read from "./UCI HAR Dataset/test/subject_test.txt"</li>
                    <li>X_test : table read from "./UCI HAR Dataset/test/X_test.txt"</li>
                    <li>y_test : table read from "./UCI HAR Dataset/test/y_test.txt"</li>
                </ul>
            </li>
            <li>
                Step 0-2 : Read the "train" Folder
                <ul>
                    <li>subject_train : table read from "./UCI HAR Dataset/train/subject_train.txt"</li>
                    <li>X_train : table read from "./UCI HAR Dataset/train/X_train.txt"</li>
                    <li>y_train : table read from "./UCI HAR Dataset/train/y_train.txt"</li>
                </ul>
            </li>
            <li>
                Step 0-3 : Read the labels("activity_labels.txt", "features")
                <ul>
                    <li>Activity_Label : table read from "./UCI HAR Dataset/activity_labels.txt"</li>
                    <li>Features : table read from "./UCI HAR Dataset/features.txt"</li>
                </ul>
            </li>
        </ol>
    </li>
    <li>
        Step 1 : Merging All Data into FullSet
        <ol>
            <li>
                Step 1-1 : Bind columns in the order of "Subject_ID", "Activity", Actual Data for each folders("test", "train")
                <ul>
                    <li>TestSet : data frame that binded subject_test, y_test, X_test</li>
                    <li>TrainSet : data frame that binded subject_train, y_train, X_train</li>
                </ul>
            </li>
            <li>
                Step 1-2 : Bind rows of the two data sets
                <ul>
                    <li>FullSet : data frame that binded "TestSet" and "TrainSet"</li>
                </ul>
            </li>
            <li>
                Step 1-3 : Remove no longer needed data from global environment to avoid confusion
            </li>
        </ol>
    </li>
    <li>
        Step 2 : Extracts only the measurements on the mean&stv
        <ol>
            <li>
                Step 2-1 : Get the column index where the data description includes the word "mean" or "std"
                <ul>
                    <li>Index : column index where the feature includes the word "mean" or "std"</li>
                </ul>
            </li>
            <li>
                Step 2-2 : Using the index we got, retrieve the data from full set.
                <ul>
                    <li>TempSet : retrieved data that has "mean" or "std" in their feature name.</li>
                </ul>
            </li>
        </ol>
    </li>
    <li>
        Step 3 : Replacing numbered activity with descriptive character.
        <ol>
            <li>
                Step3-1 : Create a map that connects the numbered activity with descriptive string.
                <ul>
                    <li>map : map of numbered acitivity and descriptive character value</li>
                </ul>
            </li>
            <li>
                Step3-2 : Remove no longer needed data from global environment to avoid confusion
            </li>
            <li>
                Step3-3 : For every value in "Activity" column,
                <ul>
                    <li>change the atomic type of the column into character</li>
                    <li>change the numbered value into charactered, descriptive value.</li>
                </ul>
            </li>
            <li>
                Step3-4 : Remove no longer needed data from global environment to avoid confusion
            </li>
        </ol>
    </li>
    <li>
        Step 4 : Adding Column Names
        <ol>
            <li>
                Step 4-1 : Change the type of "Features" into character vector
                <ul>
                    <li>Features : </li>
                </ul>
            </li>
            <li>Step 4-2 : Using colnames() function, add column names for more descriptive data. Remember first two columns are added manually(i.e. "TestSet = cbind(subject_test, y_test, X_test)")</li>
        </ol>
    </li>
    <li>
        Step 5 : Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
        <ul>
            <li>
                Step 5-1 : Tidy data gathered using "Activity"
                <ol>
                    <li>
                        Step 5-1-1 : Create an empty data.frame of dimension (6,80) with "Activity" as row names
                        <ul>
                            <li>
                                ByActivity : empty data.frame of dimension (6, 80) with "Activity" as row names
                            </li>
                        </ul>
                    </li>
                    <li>Step 5-1-2 : Add the column name</li>
                    <li>Step 5-1-3 : For each row(i.e. activity), fill up the data by "Activity Name" and mean of each feature that corresponds to each activity.</li>
                    <li>Step 5-1-4 : Remove no longer needed data from global environment to avoid confusion</li>
                    <li>Step 5-1-5 : Write it out in a .txt file</li>
                </ol>
            </li>
            <li>
                Step 5-2 : Tidy data gathered using "Subject_ID"
                <ol>
                    <li>
                        Step 5-2-1 : Create an empty data.frame of dimension (6,80)
                        <ul>
                            <li>
                                BySubject : empty data.frame of dimension(6, 80)
                            </li>
                        </ul>
                    </li>
                    <li>Step 5-2-2 : Add the column name</li>
                    <li>Step 5-2-3 : For each row(i.e. subject), fill up the data by "Subject Number" and mean of each feature that corresponds to each subject.</li>
                    <li>Step 5-2-4 : Write it out in a .txt file</li>
                </ol>
            </li>
        </ul>
    </li>
</ol>
