
# House Prices: Advanced Regression Techniques

Kaggle prediction competition: predicting sales prices Y with high dimentional feature space - 79 explanatory variables (X1,X2,X3,.........X79).

Click [here](https://www.kaggle.com/c/house-prices-advanced-regression-techniques) for competition information

### Table of Contents

Part 1: [House Prices-Data Cleaning, Data Visualization, Dimensionality Reduction, Data Preprocessing & Feature Engineering.pdf](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-Data%20Cleaning%2C%20Data%20Visualization%2C%20Dimensionality%20Reduction%2C%20Data%20Preprocessing%20%26%20Feature%20Engineering.pdf)



- **R Markdown File**: 

  * [Data Cleaning](#dc)
  * [Data Visualization](#dv)
  * [Dimensionality Reduction](#dr)
  * [Data Preprocessing](#dp)
  * [Feature Engineering](#fe)

Part 2: [House Prices- Advanced Regression Techniques.ipynb](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-%20Advanced%20Regression%20Techniques.ipynb)


- **Python Jupyter Notebook File**: 

  * [Machine Learning Model Training](#notebook)
  * [Deep Learning Model Training](#notebook)
  * [Hyperparameter Tuning](#notebook)
  * [Model Selection](#notebook)
  * [Residual & Error Analysis](#notebook)

## House Prices-Data Cleaning, Data Visualization, Dimensionality Reduction, Data Preprocessing & Feature Engineering

Click [here](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-Data%20Cleaning%2C%20Data%20Visualization%2C%20Dimensionality%20Reduction%2C%20Data%20Preprocessing%20%26%20Feature%20Engineering.pdf) to view R workbook

### Data Cleaning <a name="dc"></a>

Missing Data Visualization:

<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/missingdata.png" width="850" height="350">

Data After Cleaning:

<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/cleaned.png" width="850" height="350">


### Data Visualization <a name="dv"></a>

Sample Visualizations:

  * Goal of visualization is to identify relationships between the predictor variables (x1,x2,x3,....) and the response (y)

#### SalesPrice Distribution
<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/distribution.png" width="500" height="300">

#### LotFrontage vs SalePrice by OverallQuality
<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/spvslf.png" width="550" height="300">

#### YearBuilt vs SalePrice by OverallQuality
<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/spvsyb.png" width="550" height="350">


### Dimensionality Reduction <a name="dr"></a>

2D visualizing of high dimensional  feature space - 79+D dimensions  using [Principal Component Analysis](https://en.wikipedia.org/wiki/Principal_component_analysis#:~:text=Principal%20component%20analysis%20(PCA)%20is,components%20and%20ignoring%20the%20rest.)

<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/pca.png" width="650" height="450">

### Data Preprocessing <a name="dp"></a>

View in [R workbook](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-Data%20Cleaning%2C%20Data%20Visualization%2C%20Dimensionality%20Reduction%2C%20Data%20Preprocessing%20%26%20Feature%20Engineering.pdf)


  * Categorical data is processed using [One-Hot Encoding](https://hackernoon.com/what-is-one-hot-encoding-why-and-when-do-you-have-to-use-it-e3c6186d008f)
### Feature Engineering <a name="fe"></a>

View in [R workbook](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-Data%20Cleaning%2C%20Data%20Visualization%2C%20Dimensionality%20Reduction%2C%20Data%20Preprocessing%20%26%20Feature%20Engineering.pdf)


  * lm() binary logistic regression call is used to determine features ~ x1,x2,x3,.... that are statistically significant in explaining variance in response ~ y


## House Prices: Machine Learning Model Training, Tuning, Testing <a name="notebook"></a>

Click view [ipython workbook](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-%20Advanced%20Regression%20Techniques.ipynb) 

### Hyperparameter Tuning:
  * Used to identify hyperamater for models for best performance under K-Fold cross validation error
  
### Residual Analysis:
  * Used to identify normality assumption of errors terms, signifies model captures proper variablity of response ~y

### Model Training Result Summary (R^2 Score):

<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/conclusions.png" width="425" height="200">


