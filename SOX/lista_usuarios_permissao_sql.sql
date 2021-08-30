

-- SQL 2000

Select username,profil as perfil  , sl1.createdate,'ITX'as Sistema
	from (
			select name  AS username , user_name(sm.groupuid) as profil 
			from master.sysusers su inner join master.sysmembers  sm on  su.uid=sm.memberuid
			union all
			
			select loginname as  username,
			case 
				when sysadmin = 1 THEN 'sysadmin'
				when securityadmin = 1 then 'securityadmin'
				when serveradmin = 1 then 'serveradmin'
				when setupadmin = 1 then 'setupadmin'
				when processadmin = 1 then  'processadmin'
				when diskadmin = 1 then  'diskadmin'
				when dbcreator = 1 then 'dbcreator'
				when bulkadmin = 1 then 'bulkadmin' 
				else 'Public' end as profil
			from master..syslogins sl
		) as X
		inner join master..syslogins sl1 on X.username = sl1.name
	where ( username not like '#%') and ( username not in ('') ) and profil <> 'Public'



-- SQL 2005 ou superior


	select r.name as Profile, m.name as Principal,r.create_date DataCriacao,r.modify_date UltimaAtualizacao
	from   sys.database_role_members rm   inner join     sys.database_principals r on r.principal_id = rm.role_principal_id and r.type = 'R'
											inner join     sys.database_principals m on m.principal_id =  rm.member_principal_id
	where rm.role_principal_id > 10 --and r.is_disabled = 0
	order by r.name




    -- Segunda opcao
	select rp.name as Perfil, mp.name as Usuario,mp.create_date Data_Criacao
	from sys.database_role_members drm
	join sys.database_principals rp on (drm.role_principal_id = rp.principal_id)
	join sys.database_principals mp on (drm.member_principal_id = mp.principal_id)
	where mp.name not in ('dbo')
	order by rp.name
