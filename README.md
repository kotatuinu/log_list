# バックアップファイル確認シェルスクリプト  
 ログのバックアップなど、日付がついているファイル名の有無を確認します。  
 想定：Linux（シェルスクリプトなので）  

 お仕事で確認する必要があり、ファイル数が膨大だったので半自動で確認できるようにしたもの。
  
##使い方  
 `$ ./log_list.sh <log file list> <start date YYYYMMDD> <end date YYYYMMDD>`  
  
* log file list       ： 確認するファイルとディレクトリの一覧を格納したファイル。
* start date YYYYMMDD ： 確認する日付（開始）。形式はYYYYMMDD（たとえば20140119）
* end date YYYYMMDD   ： 確認する日付（終了）。形式はYYYYMMDD（たとえば20140129）
  

 log file listの内容は、ディレクトリ,タブ文字,ファイル名 の一覧を格納してください。  
  
 ディレクトリは、相対ディレクトリ、絶対ディレクトリのどちらでも使えます。  
  
 ファイル名は、以下のルールで一部を置き換えて検索します。  
* 文字列"YYYYMMDD"を年月日に置き換える。  
* 文字列"HH"は、ワイルドカード"*"に置きかえる。  
  
 結果は、標準出力に出ます。ファイルに残したいときは、リダイレクトしてください。  
 確認したファイルは、log_list_<start date YYYYMMDD>_<end date YYYYMMDD>.dat ファイルに出力します。  
  
  
##使用例  
 テスト環境のtest001ディレクトリ以下のファイルについて、2014/01/19 ～ 2014/01/29 のファイルがあるか確認する。  
 確認するファイルの一覧は、test001.txtに入れておく。（相対ディレクトリなので、testディレクトリに移動してスクリプト実行）  

---------------
inu@inu-virtual-machine:~/work/log_list$ ls -R  
.:  
log_list.sh  test  
  
./test:  
test001  test001.txt  test002  test002.txt  test003  test003.txt  test004  
  
./test/test001:  
test20140119  test20140121  test20140123  test20140126  test20140128  
test20140120  test20140122  test20140124  test20140127  
  
./test/test002:  
test2014011900  test2014011910  test2014011920  test2014012906  test2014012916  
test2014011901  test2014011911  test2014011922  test2014012907  test2014012917  
test2014011902  test2014011912  test2014011923  test2014012908  test2014012918  
test2014011903  test2014011913  test2014011924  test2014012909  test2014012919  
test2014011904  test2014011914  test2014012900  test2014012910  test2014012920  
test2014011905  test2014011915  test2014012901  test2014012911  test2014012922  
test2014011906  test2014011916  test2014012902  test2014012912  test2014012923  
test2014011907  test2014011917  test2014012903  test2014012913  test2014012924  
test2014011908  test2014011918  test2014012904  test2014012914  
test2014011909  test2014011919  test2014012905  test2014012915  
  
./test/test003:  
test2014011900.log  test2014011912.log  test2014012900.log  test2014012912.log  
test2014011901.log  test2014011913.log  test2014012901.log  test2014012913.log  
test2014011902.log  test2014011914.log  test2014012902.log  test2014012914.log  
test2014011903.log  test2014011915.log  test2014012903.log  test2014012915.log  
test2014011904.log  test2014011916.log  test2014012904.log  test2014012916.log  
test2014011905.log  test2014011917.log  test2014012905.log  test2014012917.log  
test2014011906.log  test2014011918.log  test2014012906.log  test2014012918.log  
test2014011907.log  test2014011919.log  test2014012907.log  test2014012919.log  
test2014011908.log  test2014011920.log  test2014012908.log  test2014012920.log  
test2014011909.log  test2014011922.log  test2014012909.log  test2014012922.log  
test2014011910.log  test2014011923.log  test2014012910.log  test2014012923.log  
test2014011911.log  test2014011924.log  test2014012911.log  test2014012924.log  
  
./test/test004:  
test20140119.log  test20140122.log  test20140126.log  
test20140120.log  test20140123.log  test20140127.log  
test20140121.log  test20140124.log  test20140128.log  
  
inu@inu-virtual-machine:~/work/log_list$ cat test/test001.txt  
test002 testYYYYMMDDHH  
test001 testYYYYMMDD  
test003 testYYYYMMDDHH.log  
test001 testYYYYMMDD  
test004 testYYYYMMDD.log  
  
inu@inu-virtual-machine:~/work/log_list$ cd test  
~/work/log_list/test$ ../log_list.sh test001.txt 20140119 20140129  
	2014/01/19	2014/01/20	2014/01/21	2014/01/22	2014/01/23	2014/01/24	2014/01/25	2014/01/26	2014/01/27	2014/01/28	2014/01/29  
test002/testYYYYMMDDHH	○										○  
test001/testYYYYMMDD	○	○	○	○	○	○		○	○	○	  
test003/testYYYYMMDDHH.log	○										○  
test001/testYYYYMMDD	○	○	○	○	○	○		○	○	○	  
test004/testYYYYMMDD.log	○	○	○	○	○	○		○	○	○	  
---------------
