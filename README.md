# perf-per-watt
perf-per-watt is a simple and basic tool to ricavate the efficiency curve for an intel based laptop
it works by loading the CPU with a synthetic benchbark, then the script tracks the battery discharge statistics to calculate how much power is
being consumed by the system. (NOTE: THIS IS AN APPROXIMATION!!!!) 

I’m not a developer and I did this piece of software in my free time, it is not professional or anything, any suggestion to make it better is well
accepted 

# Requirements:
A laptop running linux (only tested on Arch as of now, it may not work on other distros) 
TLP
Sysbench

# Installation instructions: 
just clone this repository 

# Usage: 
You need to cd in the directory just created during the clonig process, then run the PPW.sh script with root privileges 

# What will happen: 
First the screen goes black (the system is still running, don’t worry), then the benchmarks will run for about 5 minutes, after that you can
wake up the laptop and check in the PPW directory, it will have some .csv files containing the scores and the mesurements. NOTE: the power
consumed is divided in files according to the powerlevel that it referes to, you need to extract the mean of those value
