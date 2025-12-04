public function up()
{
    Schema::table('users', function (Blueprint $table) {
        $table->string('role')->default('user'); // admin / user
    });
}

public function down()
{
    Schema::table('users', function (Blueprint $table) {
        $table->dropColumn('role');
    });
}
