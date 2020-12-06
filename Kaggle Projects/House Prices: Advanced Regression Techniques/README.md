
# House Prices: Advanced Regression Techniques

Kaggle prediction competition: predicting sales prices Y with high dimentional feature space - 79 explanatory variables (X1,X2,X3,.........X79).

Click [here](https://www.kaggle.com/c/house-prices-advanced-regression-techniques) for competition information

### Table of Contents

Part 1: [House Prices-Data Cleaning, Data Visualization, Dimensionality Reduction, Data Preprocessing & Feature Engineering.pdf](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-Data%20Cleaning%2C%20Data%20Visualization%2C%20Dimensionality%20Reduction%2C%20Data%20Preprocessing%20%26%20Feature%20Engineering.pdf)



- **R Programming**: 

  * [Data Cleaning](#dc)
  * [Data Visualization](#dv)
  * [Data Preprocessing](https://people.eecs.berkeley.edu/~russell/hc.html)
  * [Dimensionality Reduction](https://people.eecs.berkeley.edu/~russell/hc.html)
  * [Feature Engineering](https://people.eecs.berkeley.edu/~russell/hc.html)

Part 2: [House Prices- Advanced Regression Techniques.ipynb](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-%20Advanced%20Regression%20Techniques.ipynb)


- **Python Programming**: 

  * [Machine Learning Model Training](#dv)
  * [Deep Learning Model Training](#dv)
  * [Hyperparameter Tuning](#dc)
  * [Model Selection](#dc)
  * [Residual & Error Analysis](#dp)

## House Prices-Data Cleaning, Data Visualization, Dimensionality Reduction, Data Preprocessing & Feature Engineering

Click [here](https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/House%20Prices-Data%20Cleaning%2C%20Data%20Visualization%2C%20Dimensionality%20Reduction%2C%20Data%20Preprocessing%20%26%20Feature%20Engineering.pdf) to view workbook

### Data Cleaning <a name="dc"></a>

Missing Data Visualization:

<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/missingdata.png" width="850" height="350">

Data After Cleaning:

<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/cleaned.png" width="850" height="350">


### Data Visualization <a name="dv"></a>

Sample Visualizations:

  * goal of visualization is to identify relationships between the predictor variables (x1,x2,x3,....) and the response (y)

#### SalesPrice Distribution
<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/distribution.png" width="500" height="300">

#### LotFrontage vs SalePrice by OverallQuality
<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/spvslf.png" width="550" height="300">

#### YearBuilt vs SalePrice by OverallQuality
<img src="https://github.com/AymenRumi/Data-Science-with-R/blob/master/Kaggle%20Projects/House%20Prices:%20Advanced%20Regression%20Techniques/README_imgs/spvsyb.png" width="550" height="350">


### Dimensionality Reduction <a name="dv"></a>

Visualizing high dimentional space - 79+ feature space in 2 Dimenions using [Principal Component Analysis](https://en.wikipedia.org/wiki/Principal_component_analysis#:~:text=Principal%20component%20analysis%20(PCA)%20is,components%20and%20ignoring%20the%20rest.)
