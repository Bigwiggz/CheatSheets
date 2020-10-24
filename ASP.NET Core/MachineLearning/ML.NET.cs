/*
BASICS OF ML.NET
*/

// 1) Instantiate a ML Context
MLContext context=new MLContext();

/*
LOADING IN DATA
*/

// 2) Load the data from a CSV file
var data=context.Data.LoadFromTextFile<InputClass>("PATH_TO_CSV_FILE", hasHeader:true,separatorChar:',');

// 2) create a "InputClass" with the columns you want to import and their types/ Also label the "Label" column you want to predict

// 2a) Loading data from multiple CSV files
var loader=context.Data.CreateTextLoader<InputClass>(hasHeader:true, separatorChar:',');
var data=loader.Load("PATH1","PATH2","PATH3",...);

// 2b) Load data from a TSV file without a header row. Allow quotes and trim whitespace.
var data=context.Data.LoadFromTextFile<InputClass>("PATH_TO_DATA_FILE",allowQuoting: true, trimWhitespace:true);

// 2c) Loading Data from SQL Databases
var loader=context.Data.CreateDatabaseLoader();
var source= new Datasource(
SqlClientFactory.Instance,
"DATABASE_CONNECTION_STRING",
"SELECT * FROM TrainingData"
);

var data=loader.Load(source);

// 2d) Loading Data from Other Sources
//Loading data into an array or other IEnumerable from an external data source.
//The following example simply createsan arrray in memory
var input=new{}
{
	new Input{Age=30, YearsExperience=10, ...},
	new Input{Age=40, YearsExperience=20, ...},
	new Input{Age=50, YearsExperience=30, ...},
	new Input{Age=60, YearsExperience=40, ...}
};

//Use Preview method to see data in IDataView DataFrame-ONLY WHEN DEBUGGIN
var preview=data.Preview()

// 3) Split the data into a training set and a test set
var trainTestData=context.Data.TrainTestSplit(data, testFraction:0.2, seed:0);

var trainData=trainTestData.TrainSet;

var testData=trainTestData.TestSet;


/*
DATA CLEANSING
*/

//Remove rows with missing values in the "Age" or "YearsExperience" columns
var view=context.Data.FilterRowsByMissingValues(data, "Age", "YearsExperience");

//Remove rows where "Age" is less than 20 or greater than 80
var view=context.Data.FilterRowsByColun(data, "Age", lowerBound: 20, upperbound: 80);

//Remove the "Age" column
var estimator=context.Transforms.DropColumns("Age");
var view=estimator.Fit(data).Transform(data);

//Replace missing values in the "Age" column
var estimator=context.Transforms.ReplaceMissingValues("Age", replacementMode:MissingValueReplacingEstimator.ReplacementMode.Mean);
var view=estimator.Fit(data).Transform(data);

//One-Hot Encoding to transform categorical data to numbers
var encoder=context.Transforms.Categorical.OneHotEncoding(
inputColumnName:"company", outputColumnName: "company_encoded"
);
var encodedData=encoder.Fit(data).Transform(data);

/*
4) 
Build an "estimator" pipeline that identifies feature columns, normalizes the values in them and applies FastForestRegression to the data
Note, here you can use other machine-learning methods
*/



var pipeline=context.Transforms.NormalizedMinMax("Col1","Col2","Col3")
	.Append(context.Transforms.Concatenate("Features","Col1","Col2","Col3"))
	.Append(context.Regression.Trainers.FastForestRegression(options));
	
//Another way to create features
var features = trainTestData.TrainSet.Schema
                .Select(col => col.Name)
                .Where(colName => colName != "Label")
                .ToArray();

// To prep string data
context.Transforms.Text.FeaturizeText("Text", "OceanProximity")
    .Append(context.Transforms.Concatenate("Features", "Features", "Text"))
	
	
/*
SPECIFYING OPTIONS WITH AN OTIONS OBJECT

*/
var options= new FastForestRegressionTrainer.Options
{
	//Only use 80% of featrues to reduce over-fitting
	FeatureFraction=0.8,
	//Simplify the model by penalizing usage of new features
	FeatureFirstusePenalty=0.1,
	//Limit the number of treees to 50
	NumberOfTrees=50
};



// 5) Train the model
var model=pipeline.Fit(trainData);

// 6) Cross-validate the model

/*
MAKING A PREDICTION
*/

PredictionEngine<InputClass,Output> predictor =
	context.Model.CreatePredictionEngine<InputClass,Output>(model);
	
InputClass input= new InputClass{...};

Output prediction=predictor.Prdict(input);

/*
SAVING THE MODEL
*/

//Save a trained model to a local zip file
context.Model.Save(model, data.Schema, "PATH_TO_ZIP_FILE")

//Load a trained model from a local zip file
DataViewSchema schema;
model=context.Model.Load("PATH_TO_ZIP_FILE", out schema)

/*
SCORING THE MODEL
*/


//Evaluate the model
var predictions=model.Transform(testData);
var metrics=context.Regression.Evaluate(predictions);
Console.WriteLine($"R2 score: {metrics.RSquared: 0.##}");

//Cross-Validation-Evaluate the model-This runs 5 cross-validataions
var scores= context.Regression.CrossValidate(data, pipeline, numberOfFolds: 5);
var mean= scores.Average(x=>x.Metrics.RSquared);
Console.WriteLine($"Mean cross-validated R2 score: {mean:0.##}");
Console.WriteLine($"RMSE:{ metrics.RootMeanSquaredError:0.##}");

//Scoring Binary Classification Models
//Evaluate Classification Model
var predictions=model.Transform(testData);
var metrics=context.BinaryClassification.Evaluate(predictions, "Label");
Console.WriteLine();
Console.WriteLine($"Accuracy: {metrics.Accuracy:P2}");
Console.WriteLine($"AUC: {metrics.AreaUnderPrecisionRecallCurve:P2}");
Console.WriteLine($"AUC: {metrics.ConfusionMatrix}");
Console.WriteLine($"F1: {metrics.F1Score:P2}");

//Scoring Binary Classification Models
//Cross-Validation-Evaluate the model-This runs 5 cross-validataions
var scores=context.BinaryClassification.CrossValidate(data, pipeline, numberOfFolds: 5);
var mean=scores.Average(x=>x.Metrics.F1Score);
Console.WriteLine($"Mean cross-validated F1 score:{mean:P2}");

//Evaluate Multiclass Classification Model
//Evaluate Multiclass Classification Model
var predictions=model.Transform(testData);
var metrics= context.MulticlassClassification.Evaluate(predictions);

Console.WriteLine();
Console.WriteLine($"Macro accuracy={(metrics.MacroAccuracy*100):0.##}%");
Console.WriteLine($"Micro accuracy={(metrics.MicroAccuracy*100):0.##}%");
Console.WriteLine($"Micro accuracy={(metrics.ConfusionMatrix):0.##}%");

//Cross-Validation-Evaluate the model-This runs 5 cross-validataions
var scores= context.MulticlassClassification.CrossValidate(data, pipeline, numberOfFolds:5);
var mean= scores.Average(x=>x.Metrics.MacroAccuracy);
Console.WriteLine($"Mean cross-validated macro accuracy: {mean:P2}");

/*
VECTORIZING TEXT
*/

var featurizer=context.Transforms.Text.FeatureizeText("Features","Text");
var transformedText=featurizer.Fit(data).Transform(data);


/*
AUTOML
*/

var settings=new RegressionExperimentSettings
{
	MaxExperimentTimeInSeconds=1800, //30 min max
	OptimizingMetric=RegressionMetric.RSquared,
	CacheDirectory=null //Cache in memory
};

var experiment=context.Auto().CreateregressionExperiment(settings);
var result=experiment.Execute(data);

var BestR2=result.BestRun.ValidationMetrics.RSquared;
var BestModel=result.BestRun.Model;