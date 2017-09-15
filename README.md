# ShellScript para registrar no JIRA da WKM os time entries feitos no Toggl.

### Instruções de uso:
 - O formato do texto do time entry no Toggl deve ter o seguinte formato:
   - "[CARD_ID] - Descrição da tarefa" Onde o CARD_ID representa o identificador do card no JIRA.
 - Deve ser gerado no Toggl o relatório detalhado dos dias que você deseja logar no JIRA, através da seguinte URL: https://toggl.com/app/reports/detailed.
 - Para o ShellScript identificar o seu usuário do JIRA, você deve criar a variável de ambiente USER com o seu login do JIRA:
   - Exemplo (esse comando deve ficar no seu .bashrc):
     ```sh
     export USER=pjesus
     ```
 - Com o CSV gerado, execute o ShellScript passando o caminho para o mesmo como parâmetro para migrar os time entries para o JIRA da WKM:
   - Exemplo
     ```
     ./logwork.sh ~/Downloads/Toggl_time_entries_2017-09-11_to_2017-09-14.csv
     ```
 - Profit
