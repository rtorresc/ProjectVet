CREATE SCHEMA IF NOT EXISTS "public";


CREATE TABLE "public"."TB_TypeMaster" (
    "IdTypeMaster" integer DEFAULT 'NEXTVAL',
    "TypeMasterCode" varchar(500) NOT NULL UNIQUE,
    "TypeMasterName" varchar(500) NOT NULL,
    "Active" boolean NOT NULL,
    PRIMARY KEY ("IdTypeMaster")
);



CREATE TABLE "public"."TB_Type" (
    "IdType" integer DEFAULT 'NEXTVAL',
    "TypeCode" varchar(500) NOT NULL UNIQUE,
    "TypeName" varchar(500) NOT NULL,
    "IdTypeMaster" integer NOT NULL,
    "Active" boolean NOT NULL,
    PRIMARY KEY ("IdType")
);



CREATE TABLE "public"."TB_Role" (
    "IdRole" integer NOT NULL,
    "RoleCode" varchar NOT NULL UNIQUE,
    "RoleName" varchar NOT NULL,
    "IsAdmin" boolean NOT NULL,
    "Active" boolean NOT NULL,
    "IdUserAction" integer,
    "UpdateDate" timestamp,
    PRIMARY KEY ("IdRole")
);



CREATE TABLE "public"."TB_Icon" (
    "IdIcon" integer NOT NULL,
    "IconName" varchar(500) NOT NULL,
    "IconPath" varchar(500),
    PRIMARY KEY ("IdIcon")
);



CREATE TABLE "public"."TB_Menu" (
    "IdMenu" integer NOT NULL,
    "MenuCode" varchar(20) NOT NULL UNIQUE,
    "MenuName" varchar(500) NOT NULL,
    "IdMenuParent" integer,
    "MenuRoute" varchar(500),
    "IdIcon" integer,
    "Active" boolean NOT NULL,
    PRIMARY KEY ("IdMenu")
);



CREATE TABLE "public"."TR_RoleMenu" (
    "IdRoleMenu" integer NOT NULL,
    "IdRole" integer NOT NULL,
    "IdMenu" integer NOT NULL,
    "Consult" boolean NOT NULL,
    "Create" boolean NOT NULL,
    "Edit" boolean NOT NULL,
    "Active" boolean NOT NULL,
    "IdUserCreate" integer NOT NULL,
    "DateCreate" timestamp NOT NULL,
    "IdUserAction" integer,
    "UpdateDate" timestamp,
    PRIMARY KEY ("IdRoleMenu")
);



CREATE TABLE "public"."TB_State" (
    "IdState" integer DEFAULT 'NEXTVAL',
    "StateCode" varchar(500) NOT NULL UNIQUE,
    "StateName" varchar(500) NOT NULL,
    "IdStateMaster" integer NOT NULL,
    "Active" boolean NOT NULL,
    PRIMARY KEY ("IdState")
);



CREATE TABLE "public"."TB_StateMaster" (
    "IdStateMaster" integer DEFAULT 'NEXTVAL',
    "StateMasterCode" varchar(500) NOT NULL UNIQUE,
    "StateMasterName" varchar(500) NOT NULL,
    "Active" boolean NOT NULL,
    PRIMARY KEY ("IdStateMaster")
);



CREATE TABLE "public"."TB_User" (
    "IdUser" integer NOT NULL,
    "UserName" varchar NOT NULL,
    "UserLastName" varchar NOT NULL,
    "Nickname" varchar NOT NULL UNIQUE,
    "Password" varchar NOT NULL,
    "IdTypeIdentification" integer NOT NULL,
    "Identification" varchar NOT NULL,
    "IdCountry" integer,
    "IdDepartment" integer,
    "IdCity" integer,
    "UserEmail" varchar NOT NULL,
    "NumberPhone" varchar,
    "Birthdate" date,
    "IdRole" integer NOT NULL,
    "IdStateUser" integer NOT NULL,
    "Active" boolean NOT NULL,
    "IdUserCreate" integer NOT NULL,
    "DateCreate" timestamp NOT NULL,
    "IdUserAction" integer,
    "DateAction" timestamp,
    PRIMARY KEY ("IdUser")
);



ALTER TABLE "public"."TB_Menu"
ADD CONSTRAINT "fk_TB_Menu_IdIcon_TB_Icon_IdIcon" FOREIGN KEY("IdIcon") REFERENCES "public"."TB_Icon"("IdIcon");

ALTER TABLE "public"."TB_Menu"
ADD CONSTRAINT "fk_TB_Menu_IdMenuParent_TB_Menu_IdMenu" FOREIGN KEY("IdMenuParent") REFERENCES "public"."TB_Menu"("IdMenu");

ALTER TABLE "public"."TB_Role"
ADD CONSTRAINT "fk_TB_Role_IdUserAction_TB_User_IdUser" FOREIGN KEY("IdUserAction") REFERENCES "public"."TB_User"("IdUser");

ALTER TABLE "public"."TB_State"
ADD CONSTRAINT "fk_TB_State_IdStateMaster_TB_StateMaster_IdStateMaster" FOREIGN KEY("IdStateMaster") REFERENCES "public"."TB_StateMaster"("IdStateMaster");

ALTER TABLE "public"."TB_Type"
ADD CONSTRAINT "fk_TB_Type_IdTypeMaster_TB_TypeMaster_IdTypeMaster" FOREIGN KEY("IdTypeMaster") REFERENCES "public"."TB_TypeMaster"("IdTypeMaster");

ALTER TABLE "public"."TB_User"
ADD CONSTRAINT "fk_TB_User_IdRole_TB_Role_IdRole" FOREIGN KEY("IdRole") REFERENCES "public"."TB_Role"("IdRole");

ALTER TABLE "public"."TB_User"
ADD CONSTRAINT "fk_TB_User_IdStateUser_TB_State_IdState" FOREIGN KEY("IdStateUser") REFERENCES "public"."TB_State"("IdState");

ALTER TABLE "public"."TB_User"
ADD CONSTRAINT "fk_TB_User_IdTypeIdentification_TB_Type_IdType" FOREIGN KEY("IdTypeIdentification") REFERENCES "public"."TB_Type"("IdType");

ALTER TABLE "public"."TB_User"
ADD CONSTRAINT "fk_TB_User_IdUserAction_TB_User_IdUser" FOREIGN KEY("IdUserAction") REFERENCES "public"."TB_User"("IdUser");

ALTER TABLE "public"."TB_User"
ADD CONSTRAINT "fk_TB_User_IdUserCreate_TB_User_IdUser" FOREIGN KEY("IdUserCreate") REFERENCES "public"."TB_User"("IdUser");

ALTER TABLE "public"."TR_RoleMenu"
ADD CONSTRAINT "fk_TR_RoleMenu_IdMenu_TB_Menu_IdMenu" FOREIGN KEY("IdMenu") REFERENCES "public"."TB_Menu"("IdMenu");

ALTER TABLE "public"."TR_RoleMenu"
ADD CONSTRAINT "fk_TR_RoleMenu_IdRole_TB_Role_IdRole" FOREIGN KEY("IdRole") REFERENCES "public"."TB_Role"("IdRole");

ALTER TABLE "public"."TR_RoleMenu"
ADD CONSTRAINT "fk_TR_RoleMenu_IdUserAction_TB_User_IdUser" FOREIGN KEY("IdUserAction") REFERENCES "public"."TB_User"("IdUser");

ALTER TABLE "public"."TR_RoleMenu"
ADD CONSTRAINT "fk_TR_RoleMenu_IdUserCreate_TB_User_IdUser" FOREIGN KEY("IdUserCreate") REFERENCES "public"."TB_User"("IdUser");
