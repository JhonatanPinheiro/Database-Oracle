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




