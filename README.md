# Voyager CLI

tiny terminal tool that fetches nasas voyager 1 and voyager 2 earth distance data straight from their distance_data js backend and updates every second when used with watch command

## install user mode

recommended for normal humans

```
curl -fsSL https://raw.githubusercontent.com/oneSevenAR/Voyager-CLI/main/install.sh | bash
```

or safer

```
curl -fsSL https://raw.githubusercontent.com/oneSevenAR/Voyager-CLI/main/install.sh -o install.sh
bash install.sh
```

## install system wide

needs sudo puts voyager in usr local bin

```
curl -fsSL https://raw.githubusercontent.com/oneSevenAR/Voyager-CLI/main/install.sh -o install.sh
sudo bash install.sh --system
```

## usage

just run

```
voyager
```

for live updating nasa data

```
watch -n 1 voyager
```

## what it does

pulls nasa distance_data js  
extracts voyager earth distance  
interpolates to current time  
uses real nasa velocities  
computes one way light time  
prints clean human readable output

## uninstall

user mode

```
rm -f ~/bin/voyager
```

system mode

```
sudo rm -f /usr/local/bin/voyager
```

## repo

https://github.com/oneSevenAR/Voyager-CLI
