# mletch v1.0 
Customizable CLI utility for displaying system information. It supports changing colors, separators, custom ASCII art and much more... (For Unix systems ONLY)

## Installation
```bash
git clone https://github.com/Ad4ndi/mletch
cd mletch
guile build.scm
```

## Usage
```
  -h            Show help
  -c <hex>      Set color for labels
  -p <hex>      Set color for logo
  -u            Uppercase output
  -l            Lowercase output
  -s <sep>      Replace ':' with custom separator
  -b <char>     Change underline character
  -i <file>     Load ASCII art
```

## Examples
```
mletch -u -s " := " -b "=" -c 00ff00
mletch -i logo.txt -l -c ff8800 -p ff6600 -s " :: "
```

## Screenshots
![image](https://github.com/user-attachments/assets/97c3ba70-fbbc-4d05-bcd0-fb61b977bd3e)
