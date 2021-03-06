Attribute VB_Name = "Module1"
Sub Stock_Market()

For Each ws In Worksheets

        ' Created a Variable to Hold File Name, Last Row, Last Column, and Year
        Dim WorksheetName As String
        Dim Open_Price As Double
        Dim Close_Price As Double
        Dim Ticker_Name As String
        Dim Total_Volume As Double
        Dim Year_End_Value, Yearly_Change As Double
        Dim Percentage_change As Double
        Dim Begin_Value As Double
        Dim Summary_Table_Row As Integer
        
        ' Keep track of the location in the summary table
         Summary_Table_Row = 2
         WorksheetName = ws.Name
         MsgBox (WorksheetName)
         Total_Volume = 0
        
        ' Determine the Last Row
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
     
For i = 2 To LastRow
            
            ' Differentiate between ticker name & take Begin value of current ticker
            If ws.Cells(i - 1, 1).Value <> ws.Cells(i, 1).Value Then
                Begin_Value = ws.Cells(i, 3).Value
            End If
            
                ' Check if we are still within the same ticker value, if it is not...
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                
                ws.Cells(1, 9).Value = "Ticker"
                ws.Cells(1, 10).Value = "Yearly Change"
                ws.Cells(1, 11).Value = "Percentage Change"
                
                'Format change for Percentage change column
                ws.Columns(11).NumberFormat = "##,##0.00%"
                ws.Cells(1, 12).Value = "Total Stock Volume"
            
                    Ticker_Name = ws.Cells(i, 1).Value
                    Year_End_Value = ws.Cells(i, 6).Value
                    Yearly_Change = (Year_End_Value - Begin_Value)
                    
                    'To avoide rows with value Zeroes
                    If (Begin_Value > 0) Then
                        Percentage_change = Yearly_Change / Begin_Value
                    End If
                    Total_Volume = Total_Volume + ws.Cells(i, 7).Value
                
                    ' Print the Ticker Name in the Summary Table
                    ws.Range("I" & Summary_Table_Row).Value = Ticker_Name
                                 
                    
                    If (Yearly_Change >= 0) Then
                        ' Print the Yearly Change to the Summary Table
                        ws.Range("J" & Summary_Table_Row).Value = Yearly_Change
                        ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4
                    Else
                        ' Print the Yearly Change to the Summary Table
                            ws.Range("J" & Summary_Table_Row).Value = Yearly_Change
                            ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
                     
                     End If
                     
                        ' Print the Brand Amount to the Summary Table
                        ws.Range("K" & Summary_Table_Row).Value = Percentage_change
        
                       ' Print the Total Volume to the Summary Table
                        ws.Range("L" & Summary_Table_Row).Value = Total_Volume
            
                    ' Add one to the summary table row
                    Summary_Table_Row = Summary_Table_Row + 1
                      
                    ' Reset the Brand Total
                    
                    Total_Volume = 0
                    Percentage_change = 0
            Else
            
                Total_Volume = Total_Volume + ws.Cells(i, 7).Value
            End If
            
        Next i
        
        'Identify Greatest % Increase
        Dim Decreased_PctChng, Current_value As Double
        Dim Current_TkrValue, Decreased_tkrvlue As String
        
        LastRow1 = ws.Cells(Rows.Count, 11).End(xlUp).Row
        MsgBox LastRow1
        
        Current_value = ws.Cells(2, 11).Value
        Current_TkrValue = ws.Cells(2, 9).Value
        For i = 2 To LastRow1
            
            'To Identify Greatest Increase
                If ws.Cells(i + 1, 11).Value > Current_value Then
                    Current_value = ws.Cells(i + 1, 11).Value
                    Current_TkrValue = ws.Cells(i + 1, 9).Value
                End If
        Next i
        
        'Identify Greatest % Decrease
        Decreased_PctChng = ws.Cells(2, 11).Value
        Decreased_tkrvlue = ws.Cells(2, 9).Value
        
        For i = 2 To LastRow1
            
            'To Identify Greatest Decrease
                If ws.Cells(i + 1, 11).Value < Decreased_PctChng Then
                    Decreased_PctChng = ws.Cells(i + 1, 11).Value
                    Decreased_tkrvlue = ws.Cells(i + 1, 9).Value
                End If
        Next i
        
         'Identify Greatest Total Volume
         Dim Current_Volume As Double
         Dim tkr_value As String
         
        Current_Volume = ws.Cells(2, 12).Value
        tkr_value = ws.Cells(2, 9).Value
        
        For i = 2 To LastRow1
            
            'To Identify Greatest Decrease
                If ws.Cells(i + 1, 12).Value > Current_Volume Then
                    Current_Volume = ws.Cells(i + 1, 12).Value
                    tkr_value = ws.Cells(i + 1, 9).Value
                End If
        Next i
        
        
        ws.Cells(1, 16).Value = "Ticker"
        ws.Cells(1, 17).Value = "Value"
        ws.Cells(2, 17).NumberFormat = "##,##0.00%"
        ws.Cells(3, 17).NumberFormat = "##,##0.00%"
        
        ws.Cells(2, 15).Value = "Greatest % Increase"
        ws.Cells(2, 16).Value = Current_TkrValue
        ws.Cells(2, 17).Value = Current_value
        
        ws.Cells(3, 15).Value = "Greatest % Decrease"
        ws.Cells(3, 16).Value = Decreased_tkrvlue
        ws.Cells(3, 17).Value = Decreased_PctChng
        
        ws.Cells(4, 15).Value = "Greatest Total Volume"
        ws.Cells(4, 17).NumberFormat = "###,###,###,###"
        ws.Cells(4, 16).Value = tkr_value
        ws.Cells(4, 17).Value = Current_Volume

Next ws
End Sub
