-----------------------------------------------------150. Tablespaces----------------------------------------
/*
PROCESSO DE CRESCIMENTO DE EXTENTS
    Nesse cenário, foi criada uma tabela ou SEGMENT que acupou o EXTENT A. Nota-se que os Datablocks desse extent são contínuos. Após criação da tabela, foi criado um índice , que ocupou
um outro EXTENT dentro da TABLESPACE A. A tabela precisou de mais espaço, no entanto, ocupou um outro extent não continuo ao anterior. A criação de uma tabela ou índice só pode ser
feita utilizando apenas UMA tablespace . A exceção fica por conta de tabelas particionadas, que pode ocupar tablespaces diferentes.
*/


---------------------------------------------------151. Estruturas Físicas------------------------------------
/*
ESTRUTURA FÍSICA É O QUE POSSO VER NO MEU HD

É oque posso ver no meu HD.

UNIDADES FÍSICAS 
    DATAFILES: Estruturas Físicas de armazenamento do Banco de dados Oracle . Os Datafiles compões as TableSpaces e a soma dos seus tamanhos é o total de tamanho da tablespaces.
*/


/*
UNIDADES FÍSICAS 
        As Unidades físicas são transparentes principalmente para os 
usuários. O DBA na maioria dos casos, também trabalha com as estruturas
lógicas , a não ser quando preocupa-se especificamente com a estruturas físicas.Por isso
é tão importante conhecer a estrutura, arquitetura e os links entre estruturas lógicas e físicas
do Oracle



SELECT * FROM USERS

CREATE INDEX
*/


---------------------------------------------------------------------152. Archive e ASM ----------------------------
/*
 UNIDADES FISICAs

 Como os Redolog funcionam de maneira circular, os dados são sobrescritos em determinado 
 momento. Para evitar perda de dados, podemos colocar o banco de dados em modo Archive, onde
 um arquivo não é obrigado no Oracle ,porém é amplamente utlizado em ambientes de produção.


 Como arquivos físicos são armazemados FILE SYSTEM - Sistema Operacional - E a opção padrão. O oracle requisita a gravação de arquivos ao SO, que gerencia através do seu 
 GERENCIADOR DE VOLUMES e grava em seu sistema de arquivos , que por sua vez, avisa ao Oracle daa gravação.


 ASM - Automatic Storage Management , onde o Oracle controla o acesso aos arquivos , sem passar pelo sistema operacional. O SO não conhece os volumes 
 que o Oracle gerencia, e nem sabe que existem arquivos no espaço em disco destinado ao Oracle.


------------------------------------------------------------------------153. Arquivos de Paramêtros -----------------

/*
UNIDADES FÍSICAS 

ESCOPOS: 

1 - Na memória
2 - Na Renicialização
3 - No mesmo momento

Em memória  - É alterado automaticamente, para isso necessita ser Dinâmico. SCOPE  = MEMORY

SPFILE - Alteração válida somente após reinicialização e não vai estar em memória. Por mais que
seja dinâmico, não desejo fazer mesmo momento. SCOPE = SPFILE

No mesmo momento e persistente - Devo trabalhar com um parâmentro dinâmico e deixar sem escopo, pois ele tratará como padrão SCOPE = BOOTH
*/


/*
UNIDADES FÍSICAS

O Comando ALTER SESSION SET reconfigura um parâmetro apenas para sessão corrente, ou seja , é ideal para se testar algo como por exemplo,
performance. Ao desligar a sessão, a alteração é desfeita e não está disponível para nenhuma outra sessão.

DICA: Verificando os parâmentros: SELECT * FROM V$parameter

*/

------------------------------------------------------------154. Trace e PSWD----------------------------------------------
/*
ORACLE ESSENCIAL DBA DESCOMPLICADO

ESTRUTURAS FÍSICAS

Passwordfile - Arquivo de senhas criptografadas para autenticação no banco de dados 

Arquivos de Backup - Geralmente compostos de DBFs, Controlfiles, archivelogs e os arquivos de inicialização.

Arquivos de Log - São os arquivos TRACE, ou .TRC, que servem para monitorar o Banco de Dados.

Arquivos de Alerta - Alert Logs, arquivos de alerta automáticos de todas as situações que ocorren nos Banco de Dados

*/


------------------------------------------155. Default Tablespace-----------------------------------

/*
UNIDADES FÍSICAS 

System e Sysaux - Armazenam toda a parte CORE do banco , ou seja,
todo o dicionário de dados é armazenado nessas duas Tablespaces.

Undo - Trabalha com a integridade do banco de dados , auxiliando
na leitura consistente. Exemplificando , os dados que não estão
COMITADOS.Algumas literaturas também podem chamar o Tablespace de undo de Trespace de Rollback.

Temp - Como já explicada anteriormente nas estrutura físicas, a Tablespace Temp é utilizada para auxiliar
a memória do Oracle em operações mais pesadas .

Obs: Um SBG amazena no máximo 32 Giga
*/

-------------------------------------------156. Estruturas de Memória - Parte 01----------------------------

/*
MEMÓRIA

    A memória RAM padrão alocada pelo Oracle no momento da instalação é de 40% da memória total do servidor.

    A memória alocada é dividida em compartilhada , que é Ultilizada por todos os usuários e processos do Oracle,
e a memória dedica, onde casa usuário possui o seu próprio espaço, ou processo.
*/


/*
ARQUIVOS DE DADOS E SISTEMA
------ System Global Area SGA
- Library Cache
- Data Dictionary Cache
- Shared Pool
- Large Pool
- Database Buffer cache
- Redolog Buffer
- Java Pool
- Streams Pool
- Outros


-----Memória Compartilhada
- Memória Dedicada -> Program Global Area PGA
- Bancos de dados (Arquivos Físicos) -> Oracle
- Instância (Memória e Processos) - > Oracle

*/



/*
MEMÓRIA

PRINCÍPIOS DA SGA

A SGA é uma área de memória compartilhada por todos os usuários da base de dados. Seu objetivo é compartilhar o acesso,
melhorando assim a performance. Casa instância possui a sua própria SGA. A SGA evita o retrabalho dos usuários.
*/




/*
O BANCO DE DADOS ORACLE QUANDO FAZEMOS UMA QUERY ELE FAZ:
SQL
ANÁLISE SINTÁTICA
ANÁLISE SEMÂNTICA
DADOS DICIONÁRIO
PLANO DE EXECUÇÃO
*/

/*LIBRARY CACHE = SQL,PLSQL,PROCEDURES,FUNCTIONS*/
/*DATA DICTIONARY CACHE = DEFINIÇÕES DE DICIONÁRIO*/
--SHARED POOL


/*
DATABASE BUFFER CACHE

O DBBC também armazena os dados comitados pelo usuário, que estão sicronizados
com os arquivos DBFs por um processo

Lê os blocos no HD com menos performance pois acesso à memória é mais rápido

*/


/*
DATABASE BUFFER CACHE


O DBBC também armazena os dados comitados pelo usuário, que serão sincronizados com os arquivos DBFs por um 
processo

Lê os blocos no HD. Com menos performance pois o acesso à memória é mais rápido

*/


-----------------------------------------------157. Entendendo o Redolog---------------------------

/*
DATABASE BUFFER  CACHE

Quanto ao tamanho do DBBC, ele irá corresponder ao tamanho do bloco configurado na criação da database (2,4,8,16 e 32k)

Quando um usuário faz uma operação DML, o bloco é copiado para a área de memória e toda a manipulação passa a ser feita
nessa área e não no disco. O DBBC mantém uma lista com blocos mais utilizados e vai liberando espaço de acordo com os 
blocos menos utilizados sempre que necessário para acessar informações novas. Ao realizar a operação e efetuar um commit,
os blocos do DBBC não são gravados na hora em disco, mantém ainda os blocos alterados para que esses sejam gravados em conjunto
com outros blocos em um momento oportuno.

*/




------------------------------------------------------------158. Estrutura de PGA

------------------------------------------------------------159. Configurando Processos

------------------------------------------------------------160. Analisando Queries no Oracle

------------------------------------------------------------161. Criando a sua conta

------------------------------------------------------------162. Realizando o Download

------------------------------------------------------------163. Baixando os Arquivos

------------------------------------------------------------164. Virtualizando

------------------------------------------------------------165. Utilitários Linux e Windows

------------------------------------------------------------166. MobaXTerm

------------------------------------------------------------167. Criando o Servidor

------------------------------------------------------------168. Snapshot e configuração de Boot

------------------------------------------------------------169. Instalando o Oracle Linux

------------------------------------------------------------170. Mídias do Oracle Linux

------------------------------------------------------------171. Conexões de Rede

------------------------------------------------------------172. Conectando-se ao Linux

------------------------------------------------------------173. Configurando o Linux
/*----------------------------------------Configurando o Oracle 11G-------

ssh root@192.168.56.102

ssh oracle@192.168.56.102

--ARQUIVO DE CONFIGURAÇAO DO ORACLE DATABASE
--TO DO

01 - COLOCANDO IP FIXO
vi /etc/hosts

#CONFIGURACAO REFERENTE AO ORACLE
192.168.0.102  localhost.localdomain  localhost
#FIM DA CONFIGURACAO DO ORACLE

--sair e salvar wq

02 - CONFIGURANDO O KERNEL

vi /etc/sysctl.conf

#CONFIGURACAO REFERENTE AO ORACLE
fs.suid_dumpable = 1
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 536870912
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048586
#FIM DA CONFIGURACAO DO ORACLE

03 - CONFIRMANDO E ATUALIZANDO O KERNEL
/sbin/sysctl –p /etc/sysctl.conf

04 - VERIFICANDO AS CONFIGURACOES DO KERNEL
/sbin/sysctl -a

05 - ARQUIVO DE LIMITES

vi /etc/security/limits.conf

#CONFIGURACAO REFERENTE AO ORACLE
oracle              soft    nproc   2047
oracle              hard    nproc   16384
oracle              soft    nofile  4096
oracle              hard    nofile  65536
oracle              soft    stack   10240
#FIM DA CONFIGURACAO DO ORACLE

06 - VERIFICANDO O DIRETORIO DE LOGIN

vi /etc/pam.d/login

#CONFIGURACAO REFERENTE AO ORACLE
session    required     /lib/security/pam_limits.so
#FIM DA CONFIGURACAO DO ORACLE

07 - DESABILITANDO MÓDULO DE SEGURANCA
vi /etc/selinux/config 

SELINUX=disabled

08 - INSTALAR OS PACOTES

08.2 - MONTAR A IMAGEM DO LINUX NA MAQUINA VIRTUAL

cd /media
ls - lart

08.3 - ENTRAR NO DVD PELO MOBA
cd Oracle\ Linux\ Server\ dvd\ 20110119/

08.4 - VERIFICAR O CONTEUDO DO CD
ls -lart

08.5 - ENTRAR NA PASTA SERVER 
cd Server

08.6 - Abaixo instalar um por um

rpm -Uvh binutils-2.*
rpm -Uvh compat-libstdc++-33*
rpm -Uvh compat-libstdc++-33*.i386.rpm
rpm -Uvh elfutils-libelf*
rpm -Uvh gcc-4.*
rpm -Uvh gcc-c++-4.*
rpm -Uvh glibc-2.*
rpm -Uvh glibc-common-2.*
rpm -Uvh glibc-devel-2.*
rpm -Uvh glibc-headers-2.*
rpm -Uvh ksh*
rpm -Uvh libaio-0.*
rpm -Uvh libaio-devel-0.*
rpm -Uvh libgomp-4.*
rpm -Uvh libgcc-4.*
rpm -Uvh libstdc++-4.*
rpm -Uvh libstdc++-devel-4.*
rpm -Uvh make-3.*
rpm -Uvh sysstat-7.*
rpm -Uvh unixODBC-2.*
rpm -Uvh unixODBC-devel-2.*
rpm -Uvh numactl-devel-*

09 - CRIANDO OS GRUPOS DE USUARIOS

groupadd oinstall
groupadd dba
groupadd oper

10 - CRIANDO O USUARIO ORACLE PARA INSTALACAO

useradd -g oinstall -G dba oracle

11 - DEFININDO A SENHA

--senha oracle
passwd oracle

12 - CRIANDO OS DIRETORIOS DE INSTALACAO DO ORACLE

mkdir -p /u01/app/oracle/product/11.2.0/db_home1
chown -R oracle.oinstall /u01

13 - Definindo LOCALHOST para o X

xhost  +localhost

14 - REINICIANDO A MAQUINA

shutdown -h 0

15 - ANTES DE INICIAR, ALTERAR A ORDEM DO BOOT PARA HD

ssh oracle@192.168.56.102

16 - VERIFICAR OS ARQUIVOS DENTRO DO DIRETORIO HOME DO ORACLE (USUARIO)

ls -lart

17 - EDITAR O ARQUIVO .bash_profile

17.2 - EXPLICAR O QUE É VARIAVEL DE AMBIENTE

17.3 ALTERANDO O ARQUIVO

vi .bash_profile

# CONFIGURACOES DO ORACLE
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR

ORACLE_HOSTNAME=localhost; export ORACLE_HOSTNAME
ORACLE_UNQNAME=orcl; export ORACLE_UNQNAME
ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_home1; export ORACLE_HOME
ORACLE_SID=orcl; export ORACLE_SID
PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

# FIM DAS CONFIGURACOES DO ORACLE

18 - CARREGANDO O BASH
. .bash_profile

19 - VERIFICANDO AS VARIAVEIS SETADAS

echo $ORACLE_HOME

shutdown -h 0

20 - COPIAR O INSTALADOR DO ORACLE

21 - ENTRAR NO U01

cd u01

ls -lart

22 - DESCOMPACTANDO OS ARQUIVOS - os tres

unzip [nome do arquivo]

23 - ACESSAR A PASTA QUE OS AQUIVOS FORAM DESCOMPACTADOS

cd database

24 -  REALIZAR UM SNAPSHOT

su - root /PARA DESLIGAR A MAQUINA/

25 - LOGAR COM ORACLE

ssh oracle@192.168.56.102

26 - TRAZER O X PARA O WINDOWS

export DISPLAY=192.168.56.1:0.0;

27 - VERIFICANDO O X

echo $DISPLAY

28 - TESTAR O X

xclock

30 - IR NA PASTA DO INSTALADOR

cd /u01/database


31 - PASSAR A INSTALACAO

./ runInstaller

----------

https://192.168.56.102:1158/em

lsnrctl start

sqlplus / as sysdba

emctl start dbconsole

----------------------------------------------------------------------------------------------------------------------------------------------------------*/

----------------------------------------------------------------174. Configurando o Linux - Parte 02

----------------------------------------------------------------175. Configurações Finais

----------------------------------------------------------------176. Criando o primeiro Snapshot

----------------------------------------------------------------177. Mídias do Oracle 11g

-----------------------------------------------------------------178. XMing

-----------------------------------------------------------------179. Configurando o XMing

-----------------------------------------------------------------180. Instalando o SGBD

-----------------------------------------------------------------181. Snapshot de SGBD

-----------------------------------------------------------------182. Criando o Banco de Dados

-----------------------------------------------------------------183. O Enterprise Manager

-----------------------------------------------------------------184. O Ambiente Windows

-----------------------------------------------------------------185. Download do Oracle 11g para Windows

-----------------------------------------------------------------186. Configurando o Servidor Windows

-----------------------------------------------------------------187. Instalando o SGBD

-----------------------------------------------------------------188. Criando o Banco de Dados

-----------------------------------------------------------------189. Criando as variáves

-----------------------------------------------------------------190. Instalando as Ferramentas

-----------------------------------------------------------------191. Dicionario de Dados

-- USUARIO DO BANCO DE DADOS QUE ESTÁ CONECTADO 
SHOW USER;

-- TABELA DUMMY
 
 SELECT 1 + 1 ; -- NO ORACLE NÃO FUNCIONA. TODOS OS COMANDOS DEVEM VIM DE UMA TABELA NO ORACLE
 
 
 SELECT 1 + 1 FROM DUAL;
 
 -- SERÁ FEITO A PROJEÇÃO DE 1 + 1 QUE SERÁ IGUAL A 2 FAZENDO UM ELIAS A COLUNA COMO SOMA DA TABELA DUAL (DUMMY)
 SELECT 1 + 1 AS SOMA FROM DUAL;
 
 
 
 
 -- VERIFICANDO O AMBIENTE
 -- B023 -> 32Bits
 -- B047 -> 64Bits
 
 SELECT METADATA FROM SYS.KOPM$;
 
-- DICIONARIOS DE DADOS
SELECT * FROM DICT;

-- UNICA - RAC
--EU ESTOU USANDO PARALELISMO ?
SELECT PARALLEL FROM V$INSTANCE;

--ESTRUTURAS DE MEMORIA
SELECT COMPONENT, CURRENT_SIZE, MIN_SIZE,MAX_SIZE
FROM V$SGA_DYNAMIC_COMPONENTS;


-- CONECTANDO A OUTRO BANCO DE DADOS
SQLPLUS SYSTEM/SENHA@NOMEDOBANCO
ORACLE_SID=BANCO01

-- NOME DO BANCO DE DADOS QUE ESTOU USANDO
SELECT NAME FROM V$DATABASE;

-- CONSULTANDO A VERSÂO DO BANCO DE DADOS
SELECT BANNER FROM V$VERSION;


-- VERIFICANDO OS PRIVILEGIOS DOS USUARIOS
SELECT * FROM USER_SYS_PRIVS;

-- TABELAS DO USUARIO
SELECT TABLE_NAME FROM USER_TABLES;


-------------------------------------------------------------------------------------192. TABLESPACE E TABELAS---------------------------------------------------------

/*
ARMAZENAMENTO
LóGICO - TABLESPACES -> SEGMENTOS (OBEJTOS) ->
EXTENSÔES (ESPAÇO) -> BLOCOS (DO SISTEMA OPERACIONAL)

FÌSICO -> DATASILES

NAO PODEMOS DETERMINAR EM QUAL FÌSICO UM OBJETO FICARA

*/

CREATE TABLE CURSOS(
	IDCURSO INT PRIMARY KEY,
	NOME VARCHAR2(30),
	CARGA INT,
) TABLESPACE USERS;


CREATE TABLE TESTE(
	IDTESTE INT,
	NOME VARCHAR2(30)
);

/*DICIONARIOS DE DADOS*/
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;

SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES
WHERE TABLE_NAME = 'CURSOS';


/*
TODO OBJETO È CRIADO POR PADRAO NA TABLESPACE
USERS EXCETO QUANDO SE ESTA LOGADO COM O USUARIO
SYSTEM - ENTAO O  OBJETO SERA CRIADO NA TABLESPACE SYSTEM
*/

/*
Quando falo de lógico e físico é que não encontro a tabela no HD
DBF (Database Físico)-> Físico
TBSPC (Table Space) -> Lógico
*/

-- Query para trazer os dados da Tabelas que existem todas as informações do Oracle
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME,
BYTES,BLOCKS,EXTENTS FROM USER_SEGMENTS;

-- Query para trazer os dados da tabelas que existem todas as informações do ORACLE
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME,
BYTES,BLOCKS,EXTENTS FROM USER_SEGMENTS
WHERE SEGMENT_NAME = 'CURSOS';



------------------------------------193. Formatando Colunas-------------------------------






