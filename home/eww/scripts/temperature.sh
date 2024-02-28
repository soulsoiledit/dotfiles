acpi -t | rg -v '20.0' | rg -o '(\d+).0' -r '$1'
