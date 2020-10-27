# -*- coding: utf-8 -*-
"""
Created on Sun Mar 15 12:52:51 2020
@author: Brian Wiggins
"""
############################################################################## 
#READ IN FILES
##############################################################################

#####Read Files into 
from google.colab import files
uploaded=files.upload()

import pandas as pd
import io
df=pd.read_csv(io.StringIO(uploaded['myfile.csv'].decode('utf-8')),sep=";")

#####READ IN Multiple Files
#This example reads in files with name of stock1.csv, stock2.csv in the same folder
stock_files=sorted(glob(('data/stocks*.csv'))
stock_files
df=pd.concat((pd.read_csv(file) for file in stock_files),ignore_index=True)

#####Multiple Files with combining columns
stock_files=sorted(glob(('data/stocks*.csv'))
stock_files
df=pd.concat((pd.read_csv(file) for file in stock_files)axis='columns',ignore_index=True)

#####Copy from clipboard into a dataframe
#Select data in excel by highlighting the data and the do the following...
df=pd.read_clipboard()



# import exploration files 
import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt 

file_path = 'path_to_data.csv'

# read in data 
data = pd.read_csv(file_path)

#write to Excel
df.to_excel('file path and name.xlsx')

#write to Excel with various worksheets
writer = pd.ExcelWriter('pandas_multiple.xlsx')

df1.to_excel(writer, sheet_name='Sheet1')
df2.to_excel(writer, sheet_name='Sheet2')

writer.save()
############################################################################## 
#Data Exploration
##############################################################################

#Gives you an html report of a dataframe
#You can install it with the following conda install -c conda-forge pandas-profiling
import pandas_profiling as pdfl
pdfl.ProfileReport(df)


#rows and columns returns (rows, columns)
data.shape

#returns the first x number of rows when head(num). Without a number it returns 5
data.head()

#returns the last x number of rows when tail(num). Without a number it returns 5
data.tail()

#returns an object with all of the column headers 
data.columns

#basic information on all columns 
data.info()

#gives basic statistics on numeric columns
data.describe()

#shows what type the data was read in as (float, int, string, bool, etc.)
data.dtypes

#shows which values are null
data.isnull()

#shows which columns have null values
data.isnull().any()

#shows for each column the percentage of null values 
data.isnull().sum() / data.shape[0]

#plot histograms for all numeric columns 
data.hist() 

#Check linear correlation
corr=data.corr()

#Plot correlation All values
corr.style.background_gradient(cmap='coolwarm')

#plot actual correlations against one value
corr_target=corr[['column name']].sort_values(by='column name',ascending=False)
corr_target.style.background_gradient(cmap='gray')

#Plot of all variables
#Plot correlations
%matplotlib inline
#import seaborn as sns

sns.pairplot(df_analysis)
#sns.pairplot(df_analysis, hue=df_analysis.columns[4]) #hue is the column name of the categorical variable
plt.show()

#matplotlib show colorbar
plt.colorbar()

############################################################################## 
#Data Manipulation
##############################################################################

# rename columns 
data.rename(index=str columns={'col_oldname':'col_newname'})

# view all rows for one column
data.col_name 
data['col_name']

# multiple columns by name
data[['col1','col2']]
data.loc[:['col1','col2']]

#columns by index 
data.iloc[:,[0:2]]

# drop columns 
data.drop('colname', axis =1) #add inplace = True to do save over current dataframe
#drop multiple 
data.drop(['col1','col2'], axis =1)

#drop rows in a column with missing data by specifying the column
df.dropna(subset=['col1','col2'])

#replace NaN values with empty string
df.fillna('', inplace=True)

#Create df of Duplicate Values
df_New = df_Original[df_Result.duplicated(subset=['col1','col2'],keep='first')]

#drop duplicate rows by index
df = df.drop_duplicates(subset='col1', keep='first')

#lambda function 
data.apply(lambda x: x.colname**2, axis =1)

# pivot table 
pd.pivot_table(data, index = 'col_name', values = 'col2', columns = 'col3')

# merge  == JOIN in SQL
pd.merge(data1, data2, how = 'inner' , on = 'col1')

# write to csv 
data.to_csv('data_out.csv')

#lambda function with multiple pandas dataframe outputs using pd.Series
def add_subtract_series(a, b):
  return pd.Series((a + b, a - b))

df[['sum', 'difference']] = df.apply(
    lambda row: add_subtract_list(row['a'], row['b']), axis=1)
	
#Replace column variable names with numbers
temp_df2 = pd.DataFrame({'data': data.data.unique(), 'data_new':range(len(data.data.unique()))})# create a temporary dataframe 
df_analysis = df.merge(temp_df2, left_on='left col',right_on='right on', how='left')# Now merge it by assigning different values to different strings.

#Bin Data
bins=(2,6.5,8)  #2 bins with cut-off of 6.5 and 8
group_names=['bad','good']
df['column name']=pd.cut(df['column name'], bins=bins, labels=group_names)
df['column name'].unique()

############################################################################## 
#Save Data Pickle
##############################################################################

#Pickling lets you save your classifier so you dont have to train it after changing
#Pickling is serialization of a Python object to "save" it
#save classifier

import pickle

with open('linearregression.pickle','wb') as f:
    pickle.dump(clf,f)
#use classifier
pickle_in=open('linearregression.pickle','rb')
clf=pickle.load(pickle_in)


############################################################################## 
#Data Preprocessing
##############################################################################

#Category Encoder
#List the column indexes that are supposed to be categorical as a colindex zero based
def categoryEncoder(df,colindex):
  for x in colindex:
    df.iloc[:,x] = df.iloc[:,x].astype('category')
  for columnName in df.columns:
    if df[columnName].dtypes=='category':
      df[columnName+'Code']=df[columnName].cat.codes
  return df
	
############################################################################## 
#Classifier Nomenclature
##############################################################################

#shuffle the dataset to insure proper cross-validation and a good distribution of numbers accross the set
import numpy as np

shuffle_index=np.random.permutation(60000)
#Added line to change type to an int8
y_train = y_train.astype(np.int8)
X_train, y_train = X_train[shuffle_index], y_train[shuffle_index]

# use SGDClassifier -Stochastic Gradient Desent-Followed in examples for evaluation
from sklearn.linear_model import SGDClassifier
sgd_clf = SGDClassifier(max_iter=5, tol=-np.infty,random_state=42)
sgd_clf.fit(X_train, y_train_5)

#Multiclass Classification
from sklearn.svm import SVC

svm_clf = SVC(gamma="auto", random_state=42)
svm_clf.fit(X_train[:1000], y_train[:1000]) # y_train, not y_train_5
svm_clf.predict([some_digit])

############################################################################## 
#Classifier Evaluation
##############################################################################

######Confusion Matrix
from sklearn.metrics import confusion_matrix

# Create a confusion matrix-Get ytrain prediction
from sklearn.model_selection import cross_val_predict

y_train_pred = cross_val_predict(sgd_clf, X_train, y_train_5, cv=3)

#Put the actual values in the first argument and the prediction in the second argument
confusion=confusion_matrix(y_train_5,y_train_pred)

#Save confusion matrix values
from sklearn import metrics
TP=confusion[1,1]  #We correctly predicted the case
TN=confusion[0,0]  #We correctly predicted it is NOT the case
FP=confusion[0,1]  #We incorrectly predicted it is the case
FN=confusion[1,0]  #We incorrectly predicted it is NOT the case

#CLASSIFICATION ACCURACY: Overall, how often is the classifier correct?

print("Classification Accuarcy",(TP + TN) / float(TP + TN + FP + FN))
print("Classification Accuarcy",metrics.accuracy_score(y_train_5,y_train_pred))

#CLASSIFICATION ERROR: Overall, how often is the classifier incorrect?
print("Classification Error",(FP + FN) / float(TP + TN + FP + FN))
print("Classification Error",1 - metrics.accuracy_score(y_train_5,y_train_pred))

#SENSITIVITY: When the actual value is positive, how often is the prediction correct?
	#How "sensitive" is the classifier to detecting positive instances?
	#Also known as "True Positive Rate" or "Recall"
print("Sensitivity",TP / float(TP + FN))
print("Sensitivity",metrics.recall_score(y_train_5,y_train_pred))

#SPECIFICTY: When the actual value is negative, how often is the prediction correct?
	#How "specific" (or "selective") is the classifier in predicting positive instances?
print("Specificity",TN / float(TN + FP))

#FALSE POSITIVE RATE: When the actual value is negative, how often is the prediction incorrect?
print("False Positive Rate",FP / float(TN + FP))

#PRECISION: When a positive value is predicted, how often is the prediction correct?
	#How "precise" is the classifier when predicting positive instances?
print("Precision",TP / float(TP + FP))
print("Precision",metrics.precision_score(y_train_5,y_train_pred))

#F1:Defined as the weighted harmonic mean of the test's precision and recall (Precision and Sensitivity ratio)
from sklearn.metrics import f1_score
print("F1 Score",metrics.f1_score(y_train_5,y_train_pred))

#####Multi-Dimensional Confusion Matrix

#multi-dimensional confusion matrix
y_train_pred = cross_val_predict(sgd_clf, X_train_scaled, y_train, cv=3)
conf_mx = confusion_matrix(y_train, y_train_pred)
conf_mx

#color plot confusion matrix
plt.matshow(conf_mx, cmap=plt.cm.viridis)
plt.show()

#Calculate error rate confusion matrix
row_sums = conf_mx.sum(axis=1, keepdims=True)
norm_conf_mx = conf_mx / row_sums

#Plot error rate confusion matrix
np.fill_diagonal(norm_conf_mx, 0)
plt.matshow(norm_conf_mx, cmap=plt.cm.viridis)
plt.xlabel('Predicted Values')
plt.ylabel('Actual Values')
plt.title('Confusion Matrix')
plt.show()


#Plot error rate confusion matrix
np.fill_diagonal(norm_conf_mx, 0)
plt.matshow(norm_conf_mx, cmap=plt.cm.viridis)
plt.xlabel('Predicted Values')
plt.ylabel('Actual Values')
plt.title('Error Rate Confusion Matrix')
plt.show()

#Get the average metric accross all individual labels in a multilable set(f1 example)
y_train_knn_pred = cross_val_predict(knn_clf, X_train, y_train, cv=3)
f1_score(y_train, y_train_knn_pred, average="macro")


######ROC CURVE AND AUC

#Calcualte the y_scores	
y_scores = cross_val_predict(sgd_clf, X_train, y_train_5, cv=3,
                             method="decision_function")	
	
#Graph the ROC curve	
from sklearn.metrics import roc_curve

fpr, tpr, thresholds = roc_curve(y_train_5, y_scores)

def plot_roc_curve(fpr, tpr, label=None):
    plt.plot(fpr, tpr, linewidth=2, label=label)
    plt.plot([0, 1], [0, 1], 'k--')
    plt.axis([0, 1, 0, 1])
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('ROC Curve Classifier')
    plt.grid(True)

plot_roc_curve(fpr, tpr)
plt.show()

# define a function that accepts a threshold and prints sensitivity and specificity
def evaluate_threshold(threshold):
    print('Sensitivity:', tpr[thresholds > threshold][-1])
    print('Specificity:', 1 - fpr[thresholds > threshold][-1])
	
#evaluate_threshold numbers
evaluate_threshold(0.5)

#AUC Curve
#A perfect classifier will have a ROC AUC equal to 1
from sklearn.metrics import roc_auc_score
roc_auc_score(y_train_5, y_scores)

#####PR CURVE

#Precision Recall Curve PR Curve
from sklearn.metrics import precision_recall_curve

precisions, recalls, thresholds = precision_recall_curve(y_train_5, y_scores)

#Plot PR Curve with threshold
def plot_precision_recall_vs_threshold(precisions, recalls, thresholds):
    plt.plot(thresholds, precisions[:-1], "b--", label="Precision")
    plt.plot(thresholds, recalls[:-1], "g-", label="Recall")
    plt.xlabel("Threshold")
    plt.legend(loc="upper left")
    plt.title("PR Curve")
    plt.ylim([0, 1])

plot_precision_recall_vs_threshold(precisions, recalls, thresholds)
plt.show()

#Plot PR Curve
plt.plot(recalls, precisions, linewidth=2)
plt.axis([0,1,0,1])
plt.xlabel('Recall')
plt.ylabel('Precision')
plt.title('Precision vs Recall')
plt.grid(True)
plt.show()

############################################################################## 
#Probability Prediction Function
##############################################################################

#Predict the probability of a classifier
clf.predict_proba([[5, 1.5]])

#Predict the class of a classifier
clf.predict([[5, 1.5]])

############################################################################## 
#Classifier One vs One and One vs Rest
##############################################################################


#Force ScikitLearn to use One-vs-One 
from sklearn.multiclass import OneVsOneClassifier
ovo_clf = OneVsOneClassifier(SGDClassifier(random_state=42))
ovo_clf.fit(X_train, y_train)
ovo_clf.predict([some_digit])

#Force ScikitLearn to use One-vs-All
from sklearn.multiclass import OneVsRestClassifier
ovr_clf = OneVsRestClassifier(SVC(gamma="auto", random_state=42))
ovr_clf.fit(X_train[:1000], y_train[:1000])
ovr_clf.predict([some_digit])

#If you used a random classifier, you would get 10%
#accuracy, so this is not such a bad score, but you can still do much better. For 
#example, simply scaling the inputs


############################################################################## 
#SVM
##############################################################################

#Example

from sklearn.datasets import make_moons
import matplotlib.pyplot as plt
X, y = make_moons(n_samples=100, noise=0.15, random_state=42)

def plot_dataset(X, y, axes):
    plt.plot(X[:, 0][y==0], X[:, 1][y==0], "bs")
    plt.plot(X[:, 0][y==1], X[:, 1][y==1], "g^")
    plt.axis(axes)
    plt.grid(True, which='both')
    plt.xlabel(r"$x_1$", fontsize=20)
    plt.ylabel(r"$x_2$", fontsize=20, rotation=0)

plot_dataset(X, y, [-1.5, 2.5, -1, 1.5])
plt.show()


from sklearn.datasets import make_moons
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import PolynomialFeatures

polynomial_svm_clf = Pipeline([
        ("poly_features", PolynomialFeatures(degree=3)),
        ("scaler", StandardScaler()),
        ("svm_clf", LinearSVC(C=10, loss="hinge", random_state=42))
    ])

polynomial_svm_clf.fit(X, y)

#Which Kernel to Use

#With so many kernels to choose from, how can you decide which
#one to use? As a rule of thumb, you should always try the linear
#kernel first (remember that LinearSVC is much faster than SVC(ker
#nel="linear")), especially if the training set is very large or if it
#has plenty of features. If the training set is not too large, you should
#try the Gaussian RBF kernel as well; it works well in most cases.
#Then if you have spare time and computing power, you can also
#experiment with a few other kernels using cross-validation and grid
#search, especially if there are kernels specialized for your training
#set’s data structure.


############################################################################## 
#Decision Tree Example
##############################################################################
 
 
import pandas as pd
import numpy as np
import os
import matplotlib.pyplot as plt
from sklearn import datasets

# Where to save the figures
PROJECT_ROOT_DIR = "."
CHAPTER_ID = "decision_trees"
CURRENT_WORKING_DIRECTORY=os.getcwd()

# to make this notebook's output stable across runs
np.random.seed(42)

# To plot pretty figures
%matplotlib inline
import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.rc('axes', labelsize=14)
mpl.rc('xtick', labelsize=12)
mpl.rc('ytick', labelsize=12)


def image_path(fig_id):
    return os.path.join(PROJECT_ROOT_DIR, "images", CHAPTER_ID, fig_id)

def save_fig(fig_id, tight_layout=True):
    print("Saving figure", fig_id)
    if tight_layout:
        plt.tight_layout()
    plt.savefig(image_path(fig_id) + ".png", format='png', dpi=300)
	
iris = datasets.load_iris()

df_iris = pd.DataFrame(data= np.c_[iris['data'], iris['target']],
                     columns= iris['feature_names'] + ['target'])
					 
df_iris.info()

corr= df_iris.corr() # Calculates correlation matrix

corr.style.background_gradient(cmap='coolwarm')

%matplotlib inline
import seaborn as sns
sns.pairplot(df_iris)
#sns.pairplot(df_iris, vars=df_iris.columns[:-1], hue=df_iris.target)
plt.show()

############################################################################## 
#Ensemble Method 
##############################################################################

#### Multiple Classifier usage Soft Voting Example

from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import VotingClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC

log_clf = LogisticRegression()
rnd_clf = RandomForestClassifier()
svm_clf = SVC()

voting_clf = VotingClassifier(
        estimators=[('lr', log_clf), ('rf', rnd_clf), ('svc', svm_clf)],
        voting='soft')
		
voting_clf.fit(X_train, y_train)

from sklearn.metrics import accuracy_score
for clf in (log_clf, rnd_clf, svm_clf, voting_clf):
     clf.fit(X_train, y_train)
     y_pred = clf.predict(X_test)
     print(clf.__class__.__name__, accuracy_score(y_test, y_pred))

LogisticRegression 0.864
RandomForestClassifier 0.872
SVC 0.888
VotingClassifier 0.896

#### Multiple Classifier usage bagging and pasting
#Note: to use pasting, set bootstrap=False

from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier

bag_clf = BaggingClassifier(
        DecisionTreeClassifier(), n_estimators=500,
        max_samples=100, bootstrap=True, n_jobs=-1,oob_score=True)
bag_clf.fit(X_train, y_train)
y_pred = bag_clf.predict(X_test)

#use the following code to show the oob_score
bag_clf.oob_score_

#Using Tensorboard in googlecolab
%load_ext tensorboard
%tensorboard --logdir logs