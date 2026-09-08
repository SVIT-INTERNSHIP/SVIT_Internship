#! /usr/bin/vvp
:ivl_version "12.0 (stable)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/system.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/vhdl_sys.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/vhdl_textio.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/v2005_math.vpi";
:vpi_module "/usr/lib/x86_64-linux-gnu/ivl/va_math.vpi";
S_0x5fef35c2e510 .scope module, "decoder_1to2" "decoder_1to2" 2 1;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "A";
    .port_info 1 /OUTPUT 1 "Y0";
    .port_info 2 /OUTPUT 1 "Y1";
o0x779a0549b018 .functor BUFZ 1, C4<z>; HiZ drive
L_0x5fef35c74af0 .functor NOT 1, o0x779a0549b018, C4<0>, C4<0>, C4<0>;
L_0x5fef35c74bc0 .functor BUFZ 1, o0x779a0549b018, C4<0>, C4<0>, C4<0>;
v0x5fef35c30400_0 .net "A", 0 0, o0x779a0549b018;  0 drivers
v0x5fef35c74910_0 .net "Y0", 0 0, L_0x5fef35c74af0;  1 drivers
v0x5fef35c749d0_0 .net "Y1", 0 0, L_0x5fef35c74bc0;  1 drivers
# The file index is used to find the file name in the following table.
:file_names 3;
    "N/A";
    "<interactive>";
    "decoder.v";
