## This will be the entry point to select desktop || notebook 
## UEFI dual boot (lanzaboot), etc.
{
    machines = {
        desktop = {
            hasSecureBoot = true;
            hasNvidia = true;
        };

        notebook = {
            hasSecureBoot = false;
            hasNvidia = false;
        };

        new = {
            hasSecureBoot = false;
            hasNvidia = false;
        };
    };
}

