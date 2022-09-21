#!/bin/sh
pgm="${0##*/}"          # Program basename
progdir="${0%/*}"       # Program directory
: ${REALPATH_CMD=$( which realpath )}
: ${SQLITE3_CMD=$( which sqlite3 )}
: ${RM_CMD=$( which rm )}
: ${MKDIR_CMD=$( which mkdir )}
: ${FORM_PATH="/opt/forms"}
: ${distdir="/usr/local/cbsd"}

MY_PATH="$( ${REALPATH_CMD} ${progdir} )"
HELPER="roundcube"

# MAIN
if [ -z "${workdir}" ]; then
	[ -z "${cbsd_workdir}" ] && . /etc/rc.conf
	[ -z "${cbsd_workdir}" ] && exit 0
	workdir="${cbsd_workdir}"
fi

set -e
. ${distdir}/cbsd.conf
. ${subrdir}/tools.subr
. ${subr}
set +e

FORM_PATH="${workdir}/formfile"

[ ! -d "${FORM_PATH}" ] && err 1 "No such ${FORM_PATH}"
[ -f "${FORM_PATH}/${HELPER}.sqlite" ] && ${RM_CMD} -f "${FORM_PATH}/${HELPER}.sqlite"

/usr/local/bin/cbsd ${miscdir}/updatesql ${FORM_PATH}/${HELPER}.sqlite ${distsharedir}/forms.schema forms
/usr/local/bin/cbsd ${miscdir}/updatesql ${FORM_PATH}/${HELPER}.sqlite ${distsharedir}/forms.schema additional_cfg
/usr/local/bin/cbsd ${miscdir}/updatesql ${FORM_PATH}/${HELPER}.sqlite ${distsharedir}/forms_system.schema system

# not neccesary here
#INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,113,"skip_networking","skip_networking",'false','false','',1, "maxlen=60", "radio", "skip_networking_yesno", "" );

${SQLITE3_CMD} ${FORM_PATH}/${HELPER}.sqlite << EOF
BEGIN TRANSACTION;
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,1,"-Globals","Globals",'Globals','PP','',1, "maxlen=60", "delimer", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,2,"timezone","System timezone",'Europe/Moscow','Europe/Moscow','',1, "maxlen=60", "inputbox", "", "" );

INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,50,"-RoundCube","RoundCube",'RoundCube','PP','',1, "maxlen=60", "delimer", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,51,"db_roundcube_password","roundcube user DB password",'roundcubepass','roundcubepass','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,52,"roundcube_product_name","roundcube_product_name",'Roundcube Webmail','Roundcube Webmail','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,53,"roundcube_skin","roundcube_skin",'elastic','elastic','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,54,"roundcube_default_host","roundcube_default_host",'127.0.0.1','127.0.0.1','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,55,"roundcube_smtp_server","roundcube_smtp_server",'127.0.0.1','127.0.0.1','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,56,"roundcube_smtp_port","roundcube_smtp_port",'587','587','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,57,"roundcube_smtp_user","roundcube_smtp_user",'%u','%u','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,58,"roundcube_smtp_pass","roundcube_smtp_pass",'%p','%p','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,58,"roundcube_des_key","roundcube_des_key",'nohvai6Eeyalahph2Fiechie','nohvai6Eeyalahph2Fiechie','',1, "maxlen=60", "inputbox", "", "" );


INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,100,"-MySQL","MySQL",'MySQL','PP','',1, "maxlen=60", "delimer", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,102,"mysql_ver","mysql version",'80','80','',1, "maxlen=5", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,103,"-Additional","Additional params",'Additional params','','',1, "maxlen=60", "delimer", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,104,"bind_address","bind_address",'127.0.0.1','127.0.0.1','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,105,"expire_logs_days","expire_logs_days",'10','10','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,106,"key_buffer_size","key_buffer_size",'16M','16M','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,107,"max_allowed_packet","max_allowed_packet",'16M','16M','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,108,"max_binlog_size","max_binlog_size",'100M','100M','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,109,"max_connections","max_connections",'151','151','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,110,"port","port",'3306','3306','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,114,"socket","socket",'/tmp/mysql.sock','/tmp/mysql.sock','',1, "maxlen=60", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,115,"sort_buffer_size","sort_buffer_size",'8M','8M','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,116,"thread_cache_size","thread_cache_size",'8','8','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,117,"thread_stack","thread_stack",'256K','256K','',1, "maxlen=6", "inputbox", "", "" );

INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,200,"-PHP","PHP",'PHP','PP','',1, "maxlen=60", "delimer", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,201,"fpm_max_children","php-fpm max children process",'4','4','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,203,"php_memory_limit","php_memory_limit",'512M','512M','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,204,"php_max_input_time","php_max_input_time",'300','300','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,205,"php_post_max_size","php_post_max_size",'32M','32M','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,206,"php_upload_max_filesize","php_upload_max_filesize",'32M','32M','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,207,"php_max_execution_time","php_max_execution_time",'0','0','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,208,"php_opcache_memory_consumption","php_opcache_memory_consumption",'128M','128M','',1, "maxlen=6", "inputbox", "", "" );

INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,300,"-NGINX","NGINX",'NGINX','PP','',1, "maxlen=60", "delimer", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,301,"nginx_worker_processes","nginx_worker_processes",'2','2','',1, "maxlen=6", "inputbox", "", "" );
INSERT INTO forms ( mytable,group_id,order_id,param,desc,def,cur,new,mandatory,attr,type,link,groupname ) VALUES ( "forms", 1,302,"nginx_ipv6_enable","nginx_ipv6_enable",'2','2','',1, "maxlen=6", "radio", "nginx_ipv6_enable_truefalse", "" );
COMMIT;
EOF

# nginx_ipv6_enable
/usr/local/bin/cbsd ${miscdir}/updatesql ${FORM_PATH}/${HELPER}.sqlite ${distsharedir}/forms_yesno.schema nginx_ipv6_enable_truefalse

# Put boolean for nginx_ipv6_enable
${SQLITE3_CMD} ${FORM_PATH}/${HELPER}.sqlite << EOF
BEGIN TRANSACTION;
INSERT INTO nginx_ipv6_enable_truefalse ( text, order_id ) VALUES ( "true", 1 );
INSERT INTO nginx_ipv6_enable_truefalse ( text, order_id ) VALUES ( "false", 0 );
COMMIT;
EOF


# yesno
/usr/local/bin/cbsd ${miscdir}/updatesql ${FORM_PATH}/${HELPER}.sqlite ${distsharedir}/forms_yesno.schema skip_networking_yesno
# Put boolean for use_sasl_yesno
${SQLITE3_CMD} ${FORM_PATH}/${HELPER}.sqlite << EOF
BEGIN TRANSACTION;
INSERT INTO skip_networking_yesno ( text, order_id ) VALUES ( "true", 1 );
INSERT INTO skip_networking_yesno ( text, order_id ) VALUES ( "false", 0 );
COMMIT;
EOF


${SQLITE3_CMD} ${FORM_PATH}/${HELPER}.sqlite << EOF
BEGIN TRANSACTION;
INSERT INTO system ( helpername, version, packages, have_restart ) VALUES ( "roundcube", "201607", "mail/roundcube", "php_fpm" );
COMMIT;
EOF

# long description
${SQLITE3_CMD} ${FORM_PATH}/${HELPER}.sqlite << EOF
BEGIN TRANSACTION;
UPDATE system SET longdesc='\\
The image contains only a RoundCube. For a full-fledged mail server, \\
please use the "postfix" image. \\
\\
RoundCube Webmail is a browser-based multilingual IMAP client with an \\
application-like user interface. It provides full functionality you \\
expect from an e-mail client, including MIME support, address book, \\
folder manipulation and message filters. RoundCube Webmail is written in \\
PHP and requires the MySQL database. The user interface is fully \\
skinnable using XHTML and CSS 2. \\
WWW: https://roundcube.net/
';
COMMIT;
EOF
