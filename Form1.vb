Imports MySql.Data.MySqlClient
Public Class Form1

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Application.Exit()
    End Sub

    Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim conn As MySqlConnection
        conn = New MySqlConnection
        conn.ConnectionString = "server=localhost; user id=root; password= ; database=ramalan"
        Try
            conn.Open()
        Catch ex As Exception
            MessageBox.Show("Ada kesalahan dalam koneksi database")
        End Try
        Dim myAdapter As New MySqlDataAdapter

        Dim sqlQuery = "SELECT * FROM users WHERE username='" + txtUsername.Text + "' AND password='" + txtPassword.Text + "'"
        Dim myCommand As New MySqlCommand
        myCommand.Connection = conn
        myCommand.CommandText = sqlQuery

        myAdapter.SelectCommand = myCommand
        Dim myData As MySqlDataReader
        myData = myCommand.ExecuteReader()

        If myData.HasRows = 0 Then
            MessageBox.Show("username dan password salah!!")
        Else
            MessageBox.Show("Login berhasil, Selamat datang " & txtUsername.Text & "!")
            Dim F As New Form2
            F.Show()
            Me.Hide()
        End If
    End Sub

    Private Sub Form1_FormClosed(sender As Object, e As FormClosedEventArgs) Handles MyBase.FormClosed
        Application.Exit()
    End Sub
End Class
