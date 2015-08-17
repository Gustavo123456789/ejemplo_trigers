<?php
require_once('clases/usuario.php');
$user=$_POST['user_name'];
$pass=$_POST['password'];
if($user!="" && $pass!="")
{
 
$usuario= new usuario();
$usuario->get_by_user_name($user,$pass);
//echo trim($usuario->id_usuario);
$var='-100';
$var2=$usuario->id_usuario;
if($var2>$var)
{  
   header('Location: handler_action_log.php?pag=listaaction');
   exit();
}
else
{   
  
}
  
}
else
{
   session_regenerate_id();
   $_SESSION['mensaje_error']="El nombre de usuario o contraseña son correctos";
   session_write_close(); 
    header('Location: index.html');
    
}
 
?>