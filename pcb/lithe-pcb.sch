EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A 11000 8500
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_SAMD:ATSAMD21G18A-A U?
U 1 1 5FDD0125
P 8850 3600
F 0 "U?" H 8300 1750 50  0000 C CNN
F 1 "ATSAMD21G18A-A" H 9400 1700 50  0000 C CNN
F 2 "Package_QFP:TQFP-48_7x7mm_P0.5mm" H 9750 1750 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/SAM_D21_DA1_Family_Data%20Sheet_DS40001882E.pdf" H 8850 4600 50  0001 C CNN
	1    8850 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 4400 7600 4400
Wire Wire Line
	8150 4500 7600 4500
Text Label 7600 4400 0    50   ~ 0
USB_DM
Text Label 7600 4500 0    50   ~ 0
USB_DP
Wire Wire Line
	8150 5100 7600 5100
Text Label 7600 5000 0    50   ~ 0
SWCLK
Text Label 7600 5100 0    50   ~ 0
SWDIO
Wire Wire Line
	8150 5300 7600 5300
Text Label 7600 5300 0    50   ~ 0
NRST
Text Label 7600 2200 0    50   ~ 0
BUTTON_0
Wire Wire Line
	8150 2200 7600 2200
Text Label 7600 2300 0    50   ~ 0
BUTTON_1
Wire Wire Line
	8150 2300 7600 2300
Text Label 7600 2400 0    50   ~ 0
BUTTON_2
Wire Wire Line
	8150 2400 7600 2400
Text Label 7600 2500 0    50   ~ 0
BUTTON_3
Wire Wire Line
	8150 2500 7600 2500
Text Label 7600 2600 0    50   ~ 0
BUTTON_4
Wire Wire Line
	8150 2600 7600 2600
Text Label 7600 2700 0    50   ~ 0
BUTTON_5
Wire Wire Line
	8150 2700 7600 2700
Text Label 7600 2800 0    50   ~ 0
BUTTON_6
Wire Wire Line
	8150 2800 7600 2800
Text Label 7600 2900 0    50   ~ 0
BUTTON_7
Wire Wire Line
	8150 2900 7600 2900
Text Label 7600 3000 0    50   ~ 0
BUTTON_8
Wire Wire Line
	8150 3000 7600 3000
Text Label 7600 3100 0    50   ~ 0
BUTTON_9
Wire Wire Line
	8150 3100 7600 3100
Wire Wire Line
	8150 3200 7600 3200
Wire Wire Line
	8150 3300 7600 3300
Wire Wire Line
	8150 3400 7600 3400
Wire Wire Line
	8150 3500 7600 3500
Text Label 7600 3200 0    50   ~ 0
JOY_RIGHT
Text Label 7600 3300 0    50   ~ 0
JOY_LEFT
Text Label 7600 3400 0    50   ~ 0
JOY_UP
Text Label 7600 3500 0    50   ~ 0
JOY_DOWN
Wire Wire Line
	9550 4200 9800 4200
Text Label 9800 4200 2    50   ~ 0
TXD
Text Label 9800 4300 2    50   ~ 0
RXD
$Comp
L Connector:TestPoint TP?
U 1 1 5FDE6561
P 9800 4200
F 0 "TP?" V 9800 4388 50  0000 L CNN
F 1 "TestPoint" V 9845 4388 50  0001 L CNN
F 2 "" H 10000 4200 50  0001 C CNN
F 3 "~" H 10000 4200 50  0001 C CNN
	1    9800 4200
	0    1    1    0   
$EndComp
Wire Wire Line
	9550 4300 9800 4300
$Comp
L Connector:TestPoint TP?
U 1 1 5FDE7321
P 9800 4300
F 0 "TP?" V 9800 4488 50  0000 L CNN
F 1 "TestPoint" V 9845 4488 50  0001 L CNN
F 2 "" H 10000 4300 50  0001 C CNN
F 3 "~" H 10000 4300 50  0001 C CNN
	1    9800 4300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FDEA1CE
P 8850 5700
F 0 "#PWR?" H 8850 5450 50  0001 C CNN
F 1 "GND" H 8855 5527 50  0000 C CNN
F 2 "" H 8850 5700 50  0001 C CNN
F 3 "" H 8850 5700 50  0001 C CNN
	1    8850 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 5700 8850 5600
Wire Wire Line
	8950 5500 8950 5600
Wire Wire Line
	8950 5600 8850 5600
Connection ~ 8850 5600
Wire Wire Line
	8850 5600 8850 5500
$Comp
L Device:C_Small C?
U 1 1 5FDECF1B
P 8350 1600
F 0 "C?" V 8121 1600 50  0000 C CNN
F 1 "1uF" V 8212 1600 50  0000 C CNN
F 2 "" H 8350 1600 50  0001 C CNN
F 3 "~" H 8350 1600 50  0001 C CNN
	1    8350 1600
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5FDEE8F1
P 6600 2350
F 0 "C?" H 6692 2396 50  0000 L CNN
F 1 "22pF" H 6692 2305 50  0000 L CNN
F 2 "" H 6600 2350 50  0001 C CNN
F 3 "~" H 6600 2350 50  0001 C CNN
	1    6600 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5FDEF2C4
P 6950 2350
F 0 "C?" H 7042 2396 50  0000 L CNN
F 1 "22pF" H 7042 2305 50  0000 L CNN
F 2 "" H 6950 2350 50  0001 C CNN
F 3 "~" H 6950 2350 50  0001 C CNN
	1    6950 2350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FDF5C39
P 8100 1700
F 0 "#PWR?" H 8100 1450 50  0001 C CNN
F 1 "GND" H 8105 1527 50  0000 C CNN
F 2 "" H 8100 1700 50  0001 C CNN
F 3 "" H 8100 1700 50  0001 C CNN
	1    8100 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	8750 1700 8750 1450
Wire Wire Line
	8750 1450 8850 1450
Wire Wire Line
	9050 1450 9050 1300
Wire Wire Line
	8850 1700 8850 1450
Connection ~ 8850 1450
Wire Wire Line
	8850 1450 8950 1450
Wire Wire Line
	8950 1700 8950 1450
Connection ~ 8950 1450
Wire Wire Line
	8950 1450 9050 1450
Wire Wire Line
	9050 1450 9150 1450
Wire Wire Line
	9150 1450 9150 1700
Connection ~ 9050 1450
Wire Wire Line
	8150 3700 7600 3700
Text Label 7600 3700 0    50   ~ 0
LED_R
$Comp
L Connector:USB_B J?
U 1 1 5FE09C27
P 2300 3350
F 0 "J?" H 2357 3817 50  0000 C CNN
F 1 "USB_B" H 2357 3726 50  0000 C CNN
F 2 "" H 2450 3300 50  0001 C CNN
F 3 " ~" H 2450 3300 50  0001 C CNN
	1    2300 3350
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5FE0ABA4
P 3200 3000
F 0 "#PWR?" H 3200 2850 50  0001 C CNN
F 1 "+5V" H 3215 3173 50  0000 C CNN
F 2 "" H 3200 3000 50  0001 C CNN
F 3 "" H 3200 3000 50  0001 C CNN
	1    3200 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 3150 3200 3150
Wire Wire Line
	3200 3150 3200 3000
Wire Wire Line
	2600 3350 3200 3350
Wire Wire Line
	2600 3450 3200 3450
Text Label 3200 3350 2    50   ~ 0
USP_DP
Text Label 3200 3450 2    50   ~ 0
USB_DM
$Comp
L power:GND #PWR?
U 1 1 5FE1264C
P 2300 3950
F 0 "#PWR?" H 2300 3700 50  0001 C CNN
F 1 "GND" H 2305 3777 50  0000 C CNN
F 2 "" H 2300 3950 50  0001 C CNN
F 3 "" H 2300 3950 50  0001 C CNN
	1    2300 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 3750 2200 3850
Wire Wire Line
	2200 3850 2300 3850
Wire Wire Line
	2300 3850 2300 3950
Wire Wire Line
	2300 3750 2300 3850
Connection ~ 2300 3850
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J?
U 1 1 5FE177EB
P 5050 4150
F 0 "J?" H 5100 4467 50  0000 C CNN
F 1 "TAG CONNECT" H 5100 4376 50  0000 C CNN
F 2 "" H 5050 4150 50  0001 C CNN
F 3 "~" H 5050 4150 50  0001 C CNN
	1    5050 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 4050 4700 4050
Wire Wire Line
	4700 4050 4700 3850
Wire Wire Line
	4850 4150 4500 4150
Wire Wire Line
	4850 4250 4700 4250
Wire Wire Line
	4700 4250 4700 4450
Wire Wire Line
	5350 4150 5800 4150
$Comp
L power:GND #PWR?
U 1 1 5FE1F81B
P 4700 4450
F 0 "#PWR?" H 4700 4200 50  0001 C CNN
F 1 "GND" H 4705 4277 50  0000 C CNN
F 2 "" H 4700 4450 50  0001 C CNN
F 3 "" H 4700 4450 50  0001 C CNN
	1    4700 4450
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5FE22063
P 4700 3850
F 0 "#PWR?" H 4700 3700 50  0001 C CNN
F 1 "+3V3" H 4715 4023 50  0000 C CNN
F 2 "" H 4700 3850 50  0001 C CNN
F 3 "" H 4700 3850 50  0001 C CNN
	1    4700 3850
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5FE23928
P 9050 1300
F 0 "#PWR?" H 9050 1150 50  0001 C CNN
F 1 "+3V3" H 9065 1473 50  0000 C CNN
F 2 "" H 9050 1300 50  0001 C CNN
F 3 "" H 9050 1300 50  0001 C CNN
	1    9050 1300
	1    0    0    -1  
$EndComp
Text Label 4500 4150 0    50   ~ 0
NRST
Text Label 5800 4050 2    50   ~ 0
SWDIO
Text Label 5800 4150 2    50   ~ 0
SWCLK
$Comp
L Regulator_Linear:MIC5504-3.3YM5 U?
U 1 1 5FE87529
P 2300 1450
F 0 "U?" H 2300 1817 50  0000 C CNN
F 1 "MIC5504-3.3YM5" H 2300 1726 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 2300 1050 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/MIC550X.pdf" H 2050 1700 50  0001 C CNN
	1    2300 1450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5FE88988
P 1150 1250
F 0 "#PWR?" H 1150 1100 50  0001 C CNN
F 1 "+5V" H 1165 1423 50  0000 C CNN
F 2 "" H 1150 1250 50  0001 C CNN
F 3 "" H 1150 1250 50  0001 C CNN
	1    1150 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 1350 1150 1250
$Comp
L Device:C_Small C?
U 1 1 5FE8FE9C
P 1150 1550
F 0 "C?" H 1242 1596 50  0000 L CNN
F 1 "1uF" H 1242 1505 50  0000 L CNN
F 2 "" H 1150 1550 50  0001 C CNN
F 3 "~" H 1150 1550 50  0001 C CNN
	1    1150 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5FE9209C
P 2800 1550
F 0 "C?" H 2892 1596 50  0000 L CNN
F 1 "1uF" H 2892 1505 50  0000 L CNN
F 2 "" H 2800 1550 50  0001 C CNN
F 3 "~" H 2800 1550 50  0001 C CNN
	1    2800 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 1450 1150 1350
Connection ~ 1150 1350
Wire Wire Line
	2700 1350 2800 1350
Wire Wire Line
	2800 1350 2800 1200
Wire Wire Line
	2800 1450 2800 1350
Connection ~ 2800 1350
$Comp
L power:GND #PWR?
U 1 1 5FE9F836
P 2300 1850
F 0 "#PWR?" H 2300 1600 50  0001 C CNN
F 1 "GND" H 2305 1677 50  0000 C CNN
F 2 "" H 2300 1850 50  0001 C CNN
F 3 "" H 2300 1850 50  0001 C CNN
	1    2300 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FEA0252
P 2800 1750
F 0 "#PWR?" H 2800 1500 50  0001 C CNN
F 1 "GND" H 2805 1577 50  0000 C CNN
F 2 "" H 2800 1750 50  0001 C CNN
F 3 "" H 2800 1750 50  0001 C CNN
	1    2800 1750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FEA091C
P 1150 1750
F 0 "#PWR?" H 1150 1500 50  0001 C CNN
F 1 "GND" H 1155 1577 50  0000 C CNN
F 2 "" H 1150 1750 50  0001 C CNN
F 3 "" H 1150 1750 50  0001 C CNN
	1    1150 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 1750 1150 1650
Wire Wire Line
	2300 1850 2300 1750
Wire Wire Line
	2800 1750 2800 1650
$Comp
L power:+3V3 #PWR?
U 1 1 5FED4030
P 2800 1200
F 0 "#PWR?" H 2800 1050 50  0001 C CNN
F 1 "+3V3" H 2815 1373 50  0000 C CNN
F 2 "" H 2800 1200 50  0001 C CNN
F 3 "" H 2800 1200 50  0001 C CNN
	1    2800 1200
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW?
U 1 1 5FED7117
P 5100 6600
F 0 "SW?" H 5100 6885 50  0000 C CNN
F 1 "RESET" H 5100 6794 50  0000 C CNN
F 2 "" H 5100 6800 50  0001 C CNN
F 3 "~" H 5100 6800 50  0001 C CNN
	1    5100 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 6600 4650 6600
Wire Wire Line
	5300 6600 5400 6600
Wire Wire Line
	5400 6600 5400 6700
$Comp
L power:GND #PWR?
U 1 1 5FEDEA37
P 5400 6700
F 0 "#PWR?" H 5400 6450 50  0001 C CNN
F 1 "GND" H 5405 6527 50  0000 C CNN
F 2 "" H 5400 6700 50  0001 C CNN
F 3 "" H 5400 6700 50  0001 C CNN
	1    5400 6700
	1    0    0    -1  
$EndComp
Text Label 4650 6600 0    50   ~ 0
NRST
$Comp
L Device:C_Small C?
U 1 1 5FEE64BD
P 5450 1500
F 0 "C?" H 5542 1546 50  0000 L CNN
F 1 "10uf" H 5542 1455 50  0000 L CNN
F 2 "" H 5450 1500 50  0001 C CNN
F 3 "~" H 5450 1500 50  0001 C CNN
	1    5450 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5FEE69AD
P 4500 1500
F 0 "C?" H 4592 1546 50  0000 L CNN
F 1 "100nF" H 4592 1455 50  0000 L CNN
F 2 "" H 4500 1500 50  0001 C CNN
F 3 "~" H 4500 1500 50  0001 C CNN
	1    4500 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5FEE7B73
P 5000 1500
F 0 "C?" H 5092 1546 50  0000 L CNN
F 1 "100nF" H 5092 1455 50  0000 L CNN
F 2 "" H 5000 1500 50  0001 C CNN
F 3 "~" H 5000 1500 50  0001 C CNN
	1    5000 1500
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5FEE7FBD
P 4500 1300
F 0 "#PWR?" H 4500 1150 50  0001 C CNN
F 1 "+3V3" H 4515 1473 50  0000 C CNN
F 2 "" H 4500 1300 50  0001 C CNN
F 3 "" H 4500 1300 50  0001 C CNN
	1    4500 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5FEE86BF
P 5000 1300
F 0 "#PWR?" H 5000 1150 50  0001 C CNN
F 1 "+3V3" H 5015 1473 50  0000 C CNN
F 2 "" H 5000 1300 50  0001 C CNN
F 3 "" H 5000 1300 50  0001 C CNN
	1    5000 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5FEE8AD6
P 5450 1300
F 0 "#PWR?" H 5450 1150 50  0001 C CNN
F 1 "+3V3" H 5465 1473 50  0000 C CNN
F 2 "" H 5450 1300 50  0001 C CNN
F 3 "" H 5450 1300 50  0001 C CNN
	1    5450 1300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FEE9476
P 4500 1700
F 0 "#PWR?" H 4500 1450 50  0001 C CNN
F 1 "GND" H 4505 1527 50  0000 C CNN
F 2 "" H 4500 1700 50  0001 C CNN
F 3 "" H 4500 1700 50  0001 C CNN
	1    4500 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FEE9D05
P 5000 1700
F 0 "#PWR?" H 5000 1450 50  0001 C CNN
F 1 "GND" H 5005 1527 50  0000 C CNN
F 2 "" H 5000 1700 50  0001 C CNN
F 3 "" H 5000 1700 50  0001 C CNN
	1    5000 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FEEA161
P 5450 1700
F 0 "#PWR?" H 5450 1450 50  0001 C CNN
F 1 "GND" H 5455 1527 50  0000 C CNN
F 2 "" H 5450 1700 50  0001 C CNN
F 3 "" H 5450 1700 50  0001 C CNN
	1    5450 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 1600 5450 1700
Wire Wire Line
	5000 1600 5000 1700
Wire Wire Line
	4500 1600 4500 1700
Wire Wire Line
	4500 1300 4500 1400
Wire Wire Line
	5000 1300 5000 1400
Wire Wire Line
	5450 1300 5450 1400
Wire Wire Line
	8150 5000 7600 5000
$Comp
L Device:R_Small R?
U 1 1 5FF0D146
P 5450 3800
F 0 "R?" H 5509 3846 50  0000 L CNN
F 1 "1K" H 5509 3755 50  0000 L CNN
F 2 "" H 5450 3800 50  0001 C CNN
F 3 "~" H 5450 3800 50  0001 C CNN
	1    5450 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4050 5450 4050
Wire Wire Line
	5450 3900 5450 4050
Connection ~ 5450 4050
Wire Wire Line
	5450 4050 5800 4050
$Comp
L power:+3V3 #PWR?
U 1 1 5FF1EF27
P 5450 3600
F 0 "#PWR?" H 5450 3450 50  0001 C CNN
F 1 "+3V3" H 5465 3773 50  0000 C CNN
F 2 "" H 5450 3600 50  0001 C CNN
F 3 "" H 5450 3600 50  0001 C CNN
	1    5450 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 3700 5450 3600
$Comp
L Device:R_Small R?
U 1 1 5FF27EE3
P 1500 1550
F 0 "R?" H 1559 1596 50  0000 L CNN
F 1 "100K" H 1559 1505 50  0000 L CNN
F 2 "" H 1500 1550 50  0001 C CNN
F 3 "~" H 1500 1550 50  0001 C CNN
	1    1500 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 1350 1500 1350
Wire Wire Line
	1500 1450 1500 1350
Connection ~ 1500 1350
Wire Wire Line
	1500 1350 1900 1350
Wire Wire Line
	1900 1550 1800 1550
Wire Wire Line
	1800 1550 1800 1750
Wire Wire Line
	1800 1750 1500 1750
Wire Wire Line
	1500 1750 1500 1650
$Comp
L Device:LED_ABGR D?
U 1 1 5FF60D8C
P 5100 5500
F 0 "D?" H 5100 5997 50  0000 C CNN
F 1 "LED_ABGR" H 5100 5906 50  0000 C CNN
F 2 "" H 5100 5450 50  0001 C CNN
F 3 "~" H 5100 5450 50  0001 C CNN
	1    5100 5500
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5FF622FC
P 4700 5700
F 0 "R?" V 4600 5750 50  0000 C CNN
F 1 "400" V 4600 5600 50  0000 C CNN
F 2 "" H 4700 5700 50  0001 C CNN
F 3 "~" H 4700 5700 50  0001 C CNN
	1    4700 5700
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5FF63245
P 4700 5500
F 0 "R?" V 4600 5550 50  0000 C CNN
F 1 "400" V 4600 5400 50  0000 C CNN
F 2 "" H 4700 5500 50  0001 C CNN
F 3 "~" H 4700 5500 50  0001 C CNN
	1    4700 5500
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5FF638D1
P 4700 5300
F 0 "R?" V 4600 5350 50  0000 C CNN
F 1 "620" V 4600 5200 50  0000 C CNN
F 2 "" H 4700 5300 50  0001 C CNN
F 3 "~" H 4700 5300 50  0001 C CNN
	1    4700 5300
	0    1    1    0   
$EndComp
Wire Wire Line
	4800 5300 4900 5300
Wire Wire Line
	4800 5500 4900 5500
Wire Wire Line
	4800 5700 4900 5700
Wire Wire Line
	4250 5300 4600 5300
Wire Wire Line
	4600 5500 4250 5500
Wire Wire Line
	4600 5700 4250 5700
Text Label 4250 5300 0    50   ~ 0
LED_R
Text Label 4250 5500 0    50   ~ 0
LED_G
Text Label 4250 5700 0    50   ~ 0
LED_B
$Comp
L power:+5V #PWR?
U 1 1 5FF84F53
P 5400 5100
F 0 "#PWR?" H 5400 4950 50  0001 C CNN
F 1 "+5V" H 5415 5273 50  0000 C CNN
F 2 "" H 5400 5100 50  0001 C CNN
F 3 "" H 5400 5100 50  0001 C CNN
	1    5400 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 5500 5400 5500
Wire Wire Line
	5400 5500 5400 5100
Wire Wire Line
	8150 3800 7600 3800
Text Label 7600 3800 0    50   ~ 0
LED_G
Wire Wire Line
	8150 3900 7600 3900
Text Label 7600 3900 0    50   ~ 0
LED_B
$Comp
L Device:Crystal_Small Y?
U 1 1 6001507D
P 6950 2050
F 0 "Y?" V 6904 2138 50  0000 L CNN
F 1 "32.768KHz" V 7000 2150 50  0000 L CNN
F 2 "" H 6950 2050 50  0001 C CNN
F 3 "~" H 6950 2050 50  0001 C CNN
	1    6950 2050
	0    1    1    0   
$EndComp
Wire Wire Line
	8150 2100 7500 2100
Wire Wire Line
	7500 2000 8150 2000
Wire Wire Line
	7500 2000 7500 1900
Wire Wire Line
	7500 1900 6950 1900
Wire Wire Line
	6950 1900 6950 1950
Wire Wire Line
	7500 2100 7500 2200
Wire Wire Line
	7500 2200 6950 2200
Wire Wire Line
	6950 2200 6950 2150
Wire Wire Line
	6950 1900 6600 1900
Wire Wire Line
	6600 1900 6600 2250
Connection ~ 6950 1900
Wire Wire Line
	6950 2250 6950 2200
Connection ~ 6950 2200
$Comp
L power:GND #PWR?
U 1 1 6010EBB1
P 6950 2550
F 0 "#PWR?" H 6950 2300 50  0001 C CNN
F 1 "GND" H 6955 2377 50  0000 C CNN
F 2 "" H 6950 2550 50  0001 C CNN
F 3 "" H 6950 2550 50  0001 C CNN
	1    6950 2550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6010F4E3
P 6600 2550
F 0 "#PWR?" H 6600 2300 50  0001 C CNN
F 1 "GND" H 6605 2377 50  0000 C CNN
F 2 "" H 6600 2550 50  0001 C CNN
F 3 "" H 6600 2550 50  0001 C CNN
	1    6600 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 2550 6600 2450
Wire Wire Line
	6950 2550 6950 2450
Wire Wire Line
	8550 1700 8550 1600
Wire Wire Line
	8550 1600 8450 1600
Wire Wire Line
	8250 1600 8100 1600
Wire Wire Line
	8100 1600 8100 1700
Text Label 2200 7100 0    50   ~ 0
JOY_DOWN
Text Label 2200 7000 0    50   ~ 0
JOY_UP
Text Label 2200 6900 0    50   ~ 0
JOY_LEFT
Text Label 2200 6800 0    50   ~ 0
JOY_RIGHT
$Comp
L power:GND #PWR?
U 1 1 5FE714F6
P 2650 7200
F 0 "#PWR?" H 2650 6950 50  0001 C CNN
F 1 "GND" H 2655 7027 50  0000 C CNN
F 2 "" H 2650 7200 50  0001 C CNN
F 3 "" H 2650 7200 50  0001 C CNN
	1    2650 7200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 6700 2650 7200
Wire Wire Line
	2750 6700 2650 6700
Wire Wire Line
	2750 7100 2200 7100
Wire Wire Line
	2750 7000 2200 7000
Wire Wire Line
	2750 6800 2200 6800
Wire Wire Line
	2750 6900 2200 6900
$Comp
L power:GND #PWR?
U 1 1 5FE58FCA
P 1600 7200
F 0 "#PWR?" H 1600 6950 50  0001 C CNN
F 1 "GND" H 1605 7027 50  0000 C CNN
F 2 "" H 1600 7200 50  0001 C CNN
F 3 "" H 1600 7200 50  0001 C CNN
	1    1600 7200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 7100 1600 7200
Connection ~ 1600 7100
Wire Wire Line
	1700 7100 1600 7100
Wire Wire Line
	1600 6900 1600 7100
Wire Wire Line
	1700 6900 1600 6900
$Comp
L Connector_Generic:Conn_01x05 J?
U 1 1 5FE28A3A
P 2950 6900
F 0 "J?" H 2900 6550 50  0000 L CNN
F 1 "JOYSTICK" H 2500 7250 50  0000 L CNN
F 2 "" H 2950 6900 50  0001 C CNN
F 3 "~" H 2950 6900 50  0001 C CNN
	1    2950 6900
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J?
U 1 1 5FE27BCC
P 1900 6900
F 0 "J?" H 1850 6550 50  0000 L CNN
F 1 "BUTTONS[8-9]" H 1250 7150 50  0000 L CNN
F 2 "" H 1900 6900 50  0001 C CNN
F 3 "~" H 1900 6900 50  0001 C CNN
	1    1900 6900
	1    0    0    -1  
$EndComp
Text Label 1150 7000 0    50   ~ 0
BUTTON_9
Text Label 1150 6800 0    50   ~ 0
BUTTON_8
Wire Wire Line
	1700 7000 1150 7000
Wire Wire Line
	1700 6800 1150 6800
Text Label 2200 5850 0    50   ~ 0
BUTTON_7
Text Label 2200 5650 0    50   ~ 0
BUTTON_6
Text Label 2200 5450 0    50   ~ 0
BUTTON_5
Text Label 2200 5250 0    50   ~ 0
BUTTON_4
$Comp
L power:GND #PWR?
U 1 1 5FE3B27A
P 2650 6050
F 0 "#PWR?" H 2650 5800 50  0001 C CNN
F 1 "GND" H 2655 5877 50  0000 C CNN
F 2 "" H 2650 6050 50  0001 C CNN
F 3 "" H 2650 6050 50  0001 C CNN
	1    2650 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 5550 2650 5750
Connection ~ 2650 5550
Wire Wire Line
	2750 5550 2650 5550
Wire Wire Line
	2650 5750 2650 5950
Connection ~ 2650 5750
Wire Wire Line
	2650 5350 2650 5550
Wire Wire Line
	2750 5750 2650 5750
Wire Wire Line
	2650 5950 2650 6050
Connection ~ 2650 5950
Wire Wire Line
	2750 5950 2650 5950
Wire Wire Line
	2750 5350 2650 5350
Wire Wire Line
	2750 5850 2200 5850
Wire Wire Line
	2750 5650 2200 5650
Wire Wire Line
	2750 5450 2200 5450
Wire Wire Line
	2750 5250 2200 5250
$Comp
L Connector_Generic:Conn_01x08 J?
U 1 1 5FE3B261
P 2950 5550
F 0 "J?" H 2900 5000 50  0000 L CNN
F 1 "BUTTONS[4-7]" H 2300 6050 50  0000 L CNN
F 2 "" H 2950 5550 50  0001 C CNN
F 3 "~" H 2950 5550 50  0001 C CNN
	1    2950 5550
	1    0    0    -1  
$EndComp
Text Label 1200 5850 0    50   ~ 0
BUTTON_3
Text Label 1200 5650 0    50   ~ 0
BUTTON_2
Text Label 1200 5450 0    50   ~ 0
BUTTON_1
Text Label 1200 5250 0    50   ~ 0
BUTTON_0
$Comp
L power:GND #PWR?
U 1 1 5FE39501
P 1650 6050
F 0 "#PWR?" H 1650 5800 50  0001 C CNN
F 1 "GND" H 1655 5877 50  0000 C CNN
F 2 "" H 1650 6050 50  0001 C CNN
F 3 "" H 1650 6050 50  0001 C CNN
	1    1650 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 5550 1650 5750
Connection ~ 1650 5550
Wire Wire Line
	1750 5550 1650 5550
Wire Wire Line
	1650 5750 1650 5950
Connection ~ 1650 5750
Wire Wire Line
	1650 5350 1650 5550
Wire Wire Line
	1750 5750 1650 5750
Wire Wire Line
	1650 5950 1650 6050
Connection ~ 1650 5950
Wire Wire Line
	1750 5950 1650 5950
Wire Wire Line
	1750 5350 1650 5350
Wire Wire Line
	1750 5850 1200 5850
Wire Wire Line
	1750 5650 1200 5650
Wire Wire Line
	1750 5450 1200 5450
Wire Wire Line
	1750 5250 1200 5250
$Comp
L Connector_Generic:Conn_01x08 J?
U 1 1 5FE258B3
P 1950 5550
F 0 "J?" H 1900 5000 50  0000 L CNN
F 1 "BUTTONS[0-3]" H 1300 6050 50  0000 L CNN
F 2 "" H 1950 5550 50  0001 C CNN
F 3 "~" H 1950 5550 50  0001 C CNN
	1    1950 5550
	1    0    0    -1  
$EndComp
Text Notes 6650 7700 0    50   ~ 0
lithe usb fight stick controller
Text Notes 9900 7850 0    50   ~ 0
0\n
Text Notes 6600 7450 0    50   ~ 0
1
Text Notes 6700 7450 0    50   ~ 0
1
Text Notes 7450 7850 0    50   ~ 0
2020-12-18
Text Notes 9250 7550 0    50   ~ 0
Copyright 2020 Erik Gilling\nLicensed under the MIT licence.
$EndSCHEMATC