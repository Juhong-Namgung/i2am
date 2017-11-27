import math
import matplotlib.pyplot as plt

def printGraph(dataList, algorithm, numOfTrials):
    Y = [float(data) for data in dataList]
    # ax.get_yaxis().set_visible(False)
    plt.xlabel('Times')
    plt.ylabel('Sequences')
    plt.title(algorithm)
    plt.ylim([min(Y)*0.7, max(Y)*1.3])
    if algorithm == 'Reservoir':
        plt.plot(Y, 'r')
    elif algorithm == 'Hash':
        plt.plot(Y, 'purple')
    elif algorithm == 'Priority':
        plt.plot(Y, 'darkgreen')
    else:
        plt.plot(Y)

    plt.savefig(str(numOfTrials) + '_' + str(algorithm), dpi = 350)
    plt.close()

def printSinGraph():
    T = range(100)
    X = [(2 * math.pi * t) / len(T) for t in T]
    Y = [math.sin(value) for value in X]
    plt.plot(X, Y)
    plt.show()