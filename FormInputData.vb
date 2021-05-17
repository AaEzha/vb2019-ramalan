Imports MySql.Data.MySqlClient

Public Class FormInputData
    Dim str As String = "server=localhost; user=root; pass=; database=ramalan"
    Dim conn As New MySqlConnection(str)

    Sub load()
        Dim query As String = "select periode, bulan, tahun, permintaan from data_mentah"
        Dim adpt As New MySqlDataAdapter(query, conn)
        Dim ds As New DataSet()
        adpt.Fill(ds)
        DataGridView1.DataSource = ds.Tables(0)
        conn.Close()
        txtPeriode.Clear()
        txtBulan.Clear()
        txtTahun.Clear()
        txtPermintaan.Clear()
        txtCari.Clear()
    End Sub
    Private Sub FormInputData_FormClosed(sender As Object, e As FormClosedEventArgs) Handles MyBase.FormClosed
        Me.Hide()
        Dim F As New Form2
        F.Show()
    End Sub

    Private Sub FormInputData_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        load()
    End Sub

    Private Sub btnReset_Click(sender As Object, e As EventArgs) Handles btnReset.Click
        load()
    End Sub

    Private Sub btnInput_Click(sender As Object, e As EventArgs) Handles btnInput.Click
        Dim cmd As MySqlCommand
        conn.Open()
        Try
            cmd = conn.CreateCommand
            cmd.CommandText = "insert into data_mentah(periode, bulan, tahun, permintaan) values(@periode, @bulan, @tahun, @permintaan);"
            cmd.Parameters.AddWithValue("@periode", txtPeriode.Text)
            cmd.Parameters.AddWithValue("@bulan", txtBulan.Text)
            cmd.Parameters.AddWithValue("@tahun", txtTahun.Text)
            cmd.Parameters.AddWithValue("@permintaan", txtPermintaan.Text)
            cmd.ExecuteNonQuery()
            load()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
            load()
        End Try
    End Sub

    Private Sub DataGridView1_CellClick(sender As Object, e As DataGridViewCellEventArgs) Handles DataGridView1.CellClick
        Dim row As DataGridViewRow = DataGridView1.CurrentRow
        Try
            txtPeriode.Text = row.Cells(0).Value.ToString()
            txtBulan.Text = row.Cells(1).Value.ToString()
            txtTahun.Text = row.Cells(2).Value.ToString()
            txtPermintaan.Text = row.Cells(3).Value.ToString()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
            load()
        End Try
    End Sub

    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Dim cmd As MySqlCommand
        conn.Open()
        Try
            cmd = conn.CreateCommand
            cmd.CommandText = "update data_mentah set bulan=@bulan, tahun=@tahun, permintaan=@permintaan where periode=@periode;"
            cmd.Parameters.AddWithValue("@periode", txtPeriode.Text)
            cmd.Parameters.AddWithValue("@bulan", txtBulan.Text)
            cmd.Parameters.AddWithValue("@tahun", txtTahun.Text)
            cmd.Parameters.AddWithValue("@permintaan", txtPermintaan.Text)
            cmd.ExecuteNonQuery()
            load()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
            load()
        End Try
    End Sub

    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        Dim cmd As MySqlCommand
        conn.Open()
        Try
            cmd = conn.CreateCommand
            cmd.CommandText = "delete from data_mentah where periode=@periode;"
            cmd.Parameters.AddWithValue("@periode", txtPeriode.Text)
            cmd.ExecuteNonQuery()
            load()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
            load()
        End Try
    End Sub

    Private Sub txtCari_TextChanged(sender As Object, e As EventArgs) Handles txtCari.TextChanged
        Dim adapter As New MySqlDataAdapter
        Dim ds As New DataSet
        Try
            conn.Open()
            Dim query As String = "select periode, bulan, tahun, permintaan from data_mentah where bulan like '%" & txtCari.Text & "%'"
            Dim adpt As New MySqlDataAdapter(query, conn)
            adpt.Fill(ds)
            DataGridView1.DataSource = ds.Tables(0)
            conn.Close()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
            conn.Close()
        End Try

    End Sub
End Class