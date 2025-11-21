import matplotlib.pyplot as plt

x_values = list(range(1,5001))
y_values = [x**3 for x in x_values]

plt.scatter(x_values, y_values, c=y_values, cmap=plt.cm.Blues, edgecolors='none')

plt.title('Squares')
plt.xlabel('Values')
plt.ylabel('Squares of Values')

plt.tick_params(axis='both', which='major')

plt.show()