<?php namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class User extends Migration
{
	public function up()
	{
		$this->forge->addField([
			'id'			=> [
				'type'           	=> 'BIGINT',
				'constraint'     	=> 20,
				'unsigned'       	=> TRUE,
				'auto_increment' 	=> TRUE
			],
			'fullname'       	=> [
				'type'           	=> 'VARCHAR',
				'constraint'     	=> 100,
			],
			'gender' 		=> [
				'type'           	=> 'VARCHAR',
				'constraint' 		=> 15
			],
			'jenjang' 		=> [
				'type'           	=> 'VARCHAR',
				'constraint' 		=> 15
			],
			'phone' 		=> [
				'type'           	=> 'VARCHAR',
				'constraint' 		=> 13,
			]
		]);
		$this->forge->addKey('id', TRUE);
		$this->forge->createTable('users');
	}

	public function down()
	{
		//
	}
}
