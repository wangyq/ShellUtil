#!/bin/sh


PMDB_DIR=/var/lib/mysql/pmdb


echo You should run this script using "sudo ..." to execute it!

for tbl in t_cr_queue_info.MYI  t_global_lsdb.MYI        t_lsdb.MYI              t_policy_state.MYI         t_tc_flow_path_result.MYI t_dd.MYI             t_interface_info.MYI     t_ofpr_path_result.MYI  t_route.MYI                t_upload_history.MYI t_device_state.MYI   t_interface_queue.MYI    t_openflow_info.MYI     t_router_traffic_info.MYI  t_user.MYI t_flow_info.MYI      t_link_traffic_info.MYI  t_pma.MYI               t_routing_table.MYI        t_wirelesslink_result.MYI t_flow_state.MYI     t_log.MYI                t_policy.MYI            t_sysvar_info.MYI ;
do

	echo repair table "$tbl" ...
	myisamchk -c -r $PMDB_DIR/$tbl
	
	
done
