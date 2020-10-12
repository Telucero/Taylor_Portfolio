# Taylor Lucero
# Classification Prediction : Heart Failure
# Target : Death Event
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import tensorflow as tf

CSV_column_names = ['age', 'anaemia', 'creatinine_phosphokinase', 'diabetes', 'ejection_fraction',
            'high_blood_pressure', 'platelets', 'serum_creatine', 'serum_sodium', 'sex',
             'smoking', 'time', 'DEATH_EVENT']
DEATH_EVENT = [0 , 1]

# Loading  Dataset
dftrain = pd.read_csv("/Users/TaylorLucero/PycharmProjects/HeartFailure /heart_failure_clinical_records_dataset.csv")
dfeval = pd.read_csv("/Users/TaylorLucero/PycharmProjects/HeartFailure /heart_failure_clinical_records_dataset.csv")
target_train = dftrain.pop("DEATH_EVENT")
target_eval = dfeval.pop('DEATH_EVENT')


print(dftrain.head())

summary = dftrain.describe()
print(summary)
print(dftrain.shape)

print(target_train.head())
# 1 - Died
# 0 - Survived

# Graph Labels

# Visualize and look at the graphs

#Make multiple subplots
my_dpi = 50
fig,axes= plt.subplots( figsize=(16,16), dpi = my_dpi)
fig.delaxes(axes)
print(fig)


#Title for figure
fig.suptitle('Visual Analysis', fontsize = 25)


#Edit subplots
ax1=fig.add_subplot(4,3,1)
dftrain.age.hist(bins=20)
ax1.set_title('Age Hist.', fontsize = 15)

ax2=fig.add_subplot(4,3,2)
dftrain.anaemia.value_counts().plot(kind='barh')
ax2.set_title('Anaemia Count', fontsize = 15)

ax3=fig.add_subplot(4,3,3)
dftrain.creatinine_phosphokinase.hist(bins=100)
ax3.set_title('CPK Hist. ', fontsize = 15)

ax4=fig.add_subplot(4,3,4)
dftrain.diabetes.value_counts().plot(kind='barh')
ax4.set_title('Diabetes Count', fontsize = 15)

ax5=fig.add_subplot(4,3,5)
dftrain.ejection_fraction.hist(bins=10)
ax5.set_title('E-Fraction Hist.', fontsize = 15)

ax6=fig.add_subplot(4,3,6)
dftrain.high_blood_pressure.value_counts().plot(kind='barh')
ax6.set_title('HBlood Pressure Count', fontsize = 15)

ax7=fig.add_subplot(4,3,7)
dftrain.platelets.hist(bins=100)
ax7.set_title('Platelets Histogram', fontsize = 15)

ax8=fig.add_subplot(4,3,8)
dftrain.serum_creatinine.hist()
ax8.set_title('Serum creatinine Hist. ', fontsize = 15)

ax9=fig.add_subplot(4,3,9)
pd.concat([dftrain, target_train], axis=1).groupby('sex').DEATH_EVENT.mean().plot(kind='barh').set_xlabel('% DEATH_EVENT')
ax9.set_title('Death Event by Sex', fontsize = 15)

ax10=fig.add_subplot(4,3,10)
dftrain.smoking.value_counts().plot(kind='barh')
ax10.set_title('Smoking Count', fontsize = 15)

ax11=fig.add_subplot(4,3,11)
dftrain.time.hist()
ax11.set_title('Time passed for Follow-up', fontsize = 15)

# Training process
# Input function
def input_fn(features, labels, training=True, batch_size=70):
    # Convert the inputs to a Dataset.
    dataset = tf.data.Dataset.from_tensor_slices((dict(features), labels))

    # Shuffle and repeat if you are in training mode.
    if training:
        dataset = dataset.shuffle(1000).repeat()

    return dataset.batch(batch_size)

Feature_columns = []
for key in dftrain.keys():
    Feature_columns.append(tf.feature_column.numeric_column(key=key))

print(Feature_columns)
# Creating the model
classifier = tf.estimator.DNNClassifier(feature_columns = Feature_columns,
# hidden layers of 30 and 12 (the last layer must consist of the number of features)
                                       hidden_units=[40,12],
#the number of classes it will choose from
                                        n_classes = 2)
print(classifier)
# training the model
classifier.train(
    input_fn = lambda: input_fn(dftrain, target_train, training=True),
    steps=6000 # This tells the classifier to run for this many steps (adjust parameter)
)
# Evaluation
eval_result = classifier.evaluate(
    input_fn = lambda: input_fn(dfeval, target_eval, training=False))
print('\nTest set accuracy: {accuracy:0.3f}\n'.format(**eval_result) )

# Predictions
def input_fn(features, batch_size=256):
    # Convert the inputs to a Dataset without labels.
    return tf.data.Dataset.from_tensor_slices(dict(features)).batch(batch_size)

features = ['age', 'anaemia', 'creatinine_phosphokinase', 'diabetes', 'ejection_fraction','high_blood_pressure', 'platelets', 'serum_creatinine', 'serum_sodium', 'sex','smoking', 'time']
predict = {}

print("Please type numeric values as prompted.")
for feature in features:
  valid = True
  while valid:
    val = input(feature + ": ")
    if not val.isdigit(): valid = False

  predict[feature] = [float(val)]

predictions = classifier.predict(input_fn=lambda: input_fn(predict))
for pred_dict in predictions:
    class_id = pred_dict['class_ids'][0]
    probability = pred_dict['probabilities'][class_id]

    print('Prediction is "{}" ({:.1f}%)'.format(
        DEATH_EVENT[class_id], 100 * probability))

# Applying the model






