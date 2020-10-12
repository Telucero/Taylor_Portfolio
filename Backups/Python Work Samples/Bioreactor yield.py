import pandas as pd
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from sklearn import linear_model
import matplotlib

matplotlib.use("tkAgg")
import matplotlib.pyplot as plt
import statsmodels.api as sm
import ModTkinter as tk

df = pd.read_csv("bioreactor-yields.csv")
print(df)

data_summary = df.describe()
print(data_summary)

# Check linearity
my_dpi = 48
fig, axes = plt.subplots(figsize=(16, 16), dpi=my_dpi)
fig.delaxes(axes)

# Figure title
fig.suptitle('Yield Relationships', fontsize=25)

# Relationship of Yield and Temp
ax1 = fig.add_subplot(2, 2, 1)
plt.scatter(df['temperature'], df['yield'], color='blue')
plt.title("Yield Vs Temperature", fontsize=15)
plt.xlabel("Temperature", fontsize=14)
plt.ylabel("Yield", fontsize=14)
plt.grid(True)

# Relationship of Yield and duration
ax2 = fig.add_subplot(2, 2, 2)
plt.scatter(df['duration'], df['yield'], color='red')
plt.title("Yield Vs Duration", fontsize=15)
plt.xlabel("Duration", fontsize=14)
plt.ylabel("Yield", fontsize=14)
plt.grid(True)

# Relationship of Yield and Speed
ax3 = fig.add_subplot(2, 2, 3)
plt.scatter(df['speed'], df['yield'], color='green')
plt.title("Yield Vs Speed", fontsize=15)
plt.xlabel("Speed", fontsize=14)
plt.ylabel("Yield", fontsize=14)
plt.grid(True)

# Relationship of Yield and Baffles
ax4 = fig.add_subplot(2, 2, 4)
plt.scatter(df['baffles'], df['yield'], color='green')
plt.title("Yield Vs Baffles", fontsize=15)
plt.xlabel("Baffles", fontsize=14)
plt.ylabel("Yield", fontsize=14)
plt.grid(True)

# No linear relationship between two of the features
# Temperature and Speed have a linear relationship with Yield

# Performing the MLR

X = df[['temperature', 'speed']]
Y = df['yield']

regression = linear_model.LinearRegression()
regression.fit(X, Y)

print('Intercept: \n', regression.intercept_)
print('Coefficient: \n', regression.coef_)
# = (intercept) + Coef1 * X1 + Coef2*X2

# GUI
root = tk.Tk()

canvas = tk.Canvas(root, width=450, height=300)
root.title('Bioreactor Yield Predictor')


Intercept = ('Intercept: ', regression.intercept_)
Intercept_label = tk.Label(root, text=Intercept, justify='right')
canvas.create_window(160, 120, window=Intercept_label)
Intercept_label.pack()

Coefficients = ('Coefficients: ', regression.coef_)
Coefficients_label = tk.Label(root, text=Coefficients, justify='right')
canvas.create_window(160, 140, window=Coefficients_label)
Coefficients_label.pack()

temp_label = tk.Label(root, text='Temperature: ')
canvas.create_window(100, 100, window=temp_label)
temp_label.pack()

temp_entry = tk.Entry(root)
canvas.create_window(170, 100, window=temp_entry)
temp_entry.pack()

speed_label = tk.Label(root, text='Speed: ')
canvas.create_window(120, 120, window=speed_label)
speed_label.pack()

speed_entry = tk.Entry(root)
canvas.create_window(170, 120, window=speed_entry)
speed_entry.pack()


def values():
    global Temperature
    Temperature = float(temp_entry.get())

    global Speed
    Speed = float(speed_entry.get())

    Pred_yield = ('Predicted Yield: ', regression.predict([[Temperature, Speed]]))
    Pred_label = tk.Label(root, text=Pred_yield, bg='orange')
    canvas.create_window(100, 140, window=Pred_label)
    Pred_label.pack()


Pred_button = tk.Button(root, text='Predict Bioreactor Yield', command=values, bg='orange')
canvas.create_window(170, 150, window=Pred_button)
Pred_button.pack()

# First Plot

figure1 = plt.Figure(figsize=(6, 5), dpi=100)
ax1 = figure1.add_subplot(121)
scatter1 = FigureCanvasTkAgg(figure1, root)
scatter1.get_tk_widget().pack(side=tk.LEFT, fill=tk.BOTH)
ax1.scatter(df['temperature'].astype(float), df['yield'].astype(float), color='r')
ax1.legend(['Yield'])
ax1.set_xlabel('Temperature')
ax1.set_title('Temperature Vs Yield')



figure2 = plt.Figure(figsize=(5, 6), dpi=100)
ax2 = figure1.add_subplot(122)
ax2.scatter(df['speed'].astype(float), df['yield'].astype(float), color='g')
scatter2 = FigureCanvasTkAgg(figure2, root)
scatter2.get_tk_widget().pack(side=tk.RIGHT, fill=tk.BOTH)
ax2.legend(['Yield'])
ax2.set_xlabel('Speed')
ax2.set_title('Speed Vs Yield')


root.mainloop()

