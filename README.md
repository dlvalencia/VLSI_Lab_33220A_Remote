# WaveformGen Agilent Remote GUI (WARG)
A MATLAB GUI for Controlling the Agilent 33220A Function Generator

## Overview
WARG is a MATLAB-based graphical user interface that allows users to control the Agilent 33220A Function Generator via USB or LAN. It offers full access to the generator’s built-in waveform options and supports custom waveform uploads, making it a flexible and user-friendly tool for electrical engineering labs.

This project was completed during a summer internship, where we successfully implemented all planned features and validated the tool as a proof of concept for user-programmable signal generator automation.

## Features
### Basic Tab
- Select waveform type: Sine, Square, Ramp

- Adjust amplitude, offset, and frequency or period (linked control)

- Update parameters in real-time

### Arbitrary Tab
- Upload custom waveform data

- Define custom sampling rates

- Output via outputArb function for minimal delay

### Connection Tab
- Connect to multiple Agilent devices via USB or LAN

- Dynamically switch between instruments

### Technical Notes
- Example scripts and command-line usage are provided in the repo

- Some auxiliary test files can be ignored

- The outputArb function is preferred for arbitrary waveforms

- The memoryslot function was a prototype for using the generator’s non-volatile memory

- Currently not recommended due to long upload and processing times

## Educational Value
This project was designed with accessibility and reusability in mind. The code has been shared publicly in hopes it will benefit other students and engineers working with legacy waveform generators in lab settings.



# Photos
![alt text](WARG_example_1.png)
![alt text](WARG_example_2.png)
![alt text](WARG_example_3.png)
![alt text](WARG_example_4.png)
