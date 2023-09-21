echo $(acpi -b | rg -vP 'unav' | rg -oP '\d+%')
