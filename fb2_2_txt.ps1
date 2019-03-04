$ws = $pwd.Path
$xslt = New-Object System.Xml.Xsl.XslCompiledTransform
$xslt.Load("${ws}\FB2_2_txt.xsl")
Get-ChildItem "${ws}\fb2.unzipped" | %{
    $txtName = "${ws}\txt\$($_.Name).txt"
    $txtName
    $xslt.Transform($_.FullName, $txtName);
}