<?php
require_once('DBAbstract.php');
class Usuarios extends DBAbstract
{
	private $id_usuario;
	private $ci;
	private $nombre;
	private $ap_paterno;
	private $ap_materno;
	private $celular;
	private $fecha;
	private $email;
	private $nacionalidad;

	public function __construct()
	{

	}
	public function __construct($ci,$nombre,$ap_paterno,$ap_materno)
	{
		$this->ci=$ci;
		$this->nombre=$nombre;
		$this->ap_paterno=$ap_paterno;
		$this->ap_materno=$ap_materno;
	}
	public function __destruct()
	{

	}

	public function get_id_usuario()
	{
		return id_usuario;
	}
	public function set_id_usuario($id_usuario)
	{
		$this->id_usuario=$id_usuario;
	}
	
	public function insert()
	{
		$this->query="insert into usuarios(
				ci,nombre,ap_paterno,ap_materno,celular,fecha_nac,email,nacionalidad)
				values(
					'$this->ci','$this->nombre','$this->ap_paterno','$this->ap_materno','$this->celular','$this->fecha_nac','$this->email','$this->nacionalid'
					)
        ";
        $this->execute_single_query();
	}
	public function update()
	{
		$this->query="update usuarios set
				ci='$this->ci',nombre='$this->nombre',ap_paterno='$this->ap_paterno',ap_materno='$this->ap_materno',celular='$this->celular',fecha_nac='$this->fecha_nac',email='$this->email',nacionalidad='$this->nacionalidad'
				where id_usuario='$this->id_usuario'
					
         ";
        $this->execute_single_query();
	}
	public function delete()
	{
		$this->query="delete from usuarios
						where id_usuario='$this->id_usuario'";
$this->execute_single_query();
	}
}
?>