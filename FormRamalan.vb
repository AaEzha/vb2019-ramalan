Imports MySql.Data.MySqlClient
Public Class FormRamalan
    Dim str As String = "server=localhost; user=root; pass=; database=ramalan"
    Dim conn As New MySqlConnection(str)

    Sub load()
        'Pertama
        Dim query As String = "select * from view_proses union select * from view_total_proses"
        Dim adpt As New MySqlDataAdapter(query, conn)
        Dim ds As New DataSet()
        adpt.Fill(ds)
        DataGridView1.DataSource = ds.Tables(0)

        'Kedua
        Dim query2 As String = "select * from nilai_slope"
        Dim adpt2 As New MySqlDataAdapter(query2, conn)
        Dim ds2 As New DataSet()
        adpt2.Fill(ds2, "data")
        txtSlope.DataBindings.Add("text", ds2, "data.nilai_slope")

        'Ketiga
        Dim query3 As String = "select * from nilai_intersep"
        Dim adpt3 As New MySqlDataAdapter(query3, conn)
        Dim ds3 As New DataSet()
        adpt3.Fill(ds3, "data")
        txtIntersep.DataBindings.Add("text", ds3, "data.nilai_intersep")

        'Keempat
        Dim query4 As String = "select periode 'Periode 1-12', permintaan Permintaan, peramalan 'Peramalan 1-12', periode2 'Periode 13-24', peramalan2 'Peramalan 13-24' from view_ramalan union select * from view_total_ramalan"
        Dim adpt4 As New MySqlDataAdapter(query4, conn)
        Dim ds4 As New DataSet()
        adpt4.Fill(ds4)
        DataGridView2.DataSource = ds4.Tables(0)

        conn.Close()
    End Sub
    Private Sub FormRamalan_FormClosed(sender As Object, e As FormClosedEventArgs) Handles MyBase.FormClosed
        Me.Hide()
        Dim F As New Form2
        F.Show()
    End Sub

    Private Sub FormRamalan_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        load()
    End Sub
End Class