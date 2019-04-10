# TCL File Generated by Component Editor 13.0sp1
# Wed Apr 10 13:41:31 BRT 2019
# DO NOT MODIFY


# 
# lcd_component "lcd_component" v1.0
# Alyson, Lucas e Marcos 2019.04.10.13:41:31
# Componente que fornece a interface em hardware para a instru��o customizada de exibi��o no lcd
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module lcd_component
# 
set_module_property DESCRIPTION "Componente que fornece a interface em hardware para a instru��o customizada de exibi��o no lcd"
set_module_property NAME lcd_component
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "Alyson, Lucas e Marcos"
set_module_property DISPLAY_NAME lcd_component
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL lcd
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file lcd_component.v VERILOG PATH lcd_component.v TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave instruction dataa Input 32
add_interface_port nios_custom_instruction_slave data datab Input 32
add_interface_port nios_custom_instruction_slave en clk_en Input 1
add_interface_port nios_custom_instruction_slave clk clk Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock ""
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end rw export Output 1
add_interface_port conduit_end rs export Output 1
add_interface_port conduit_end enable export Output 1
add_interface_port conduit_end display export Output 8

