service TestSrv @(path: '/debug') {
    function echo (msg : String) returns String; // echo input
    function srvtime() returns DateTime; // server time
    function timetostring(x: DateTime) returns String;
    function foo() returns String;
}