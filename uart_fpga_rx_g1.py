import serial
import time
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# Replace 'COM14' with your serial port name
serial_port = 'COM5'
baud_rate = 9600
#parity = serial.PARITY_ODD
parity = serial.PARITY_NONE
stop_bits = serial.STOPBITS_ONE
bytesize = serial.EIGHTBITS

def main():
    try:
        # Initialize serial connection
        ser = serial.Serial(port=serial_port, 
                            baudrate=9600, 
                            parity=parity, 
                            stopbits=stop_bits, 
                            bytesize=bytesize,
                            timeout=1)
        # Receive 100000 Byte
        prev_rx = 0 
        data_cnter = [0] * 256
        for i in range(15000):
            rx_data = int.from_bytes(ser.read(2), byteorder='little')
            if rx_data != prev_rx:
                data_cnter.append(rx_data)
                prev_rx = rx_data

            #data_cnter[rx_data] += 1
            #print(rx_data)
        print(data_cnter)

        # Plot the histogram of the data
        n, bins, patches = plt.hist(data_cnter, bins=10, density=True, alpha=0.6, color='g')

# Calculate the mean and standard deviation of the data
        mu, std = np.mean(data_cnter), np.std(data_cnter)
# Create a range of values (x) from the minimum to maximum bin edges
        xmin, xmax = plt.xlim()
        x = np.linspace(xmin, xmax, num=1000)

# Calculate the normal distribution values for each x
        p = norm.pdf(x, mu, std)

# Plot the normal distribution curve
        plt.plot(x, p, 'k', linewidth=4)
        plt.show()
        
    except serial.SerialException as e:
        print(f"Error opening the serial port: {e}")

    except KeyboardInterrupt:
        print("\nProgram terminated by user.")

    finally:
        # Close the serial connection
        if 'ser' in locals() or 'ser' in globals():
            ser.close()
            print("Serial connection closed.")

if __name__ == "__main__":
    main()
