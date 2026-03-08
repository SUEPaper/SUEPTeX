import win32com.client
import os

def process_word_doc(doc_path, output_pdf_path):
    word = win32com.client.Dispatch("Word.Application")
    word.Visible = False
    
    try:
        doc = word.Documents.Open(doc_path)
        
        # 1. Remove all comments/annotations
        if doc.Comments.Count > 0:
            doc.DeleteAllComments()
            print(f"Removed {doc.Comments.Count} comments (after deletion check).")
        
        # 2. Find the page with "上海电力大学学位论文版权使用授权书"
        # We search for the text and get its page number
        find_range = doc.Content
        find_range.Find.Execute(FindText="上海电力大学学位论文版权使用授权书")
        
        if find_range.Find.Found:
            # wdActiveEndPageNumber = 3
            page_num = find_range.Information(3)
            print(f"Found authorization letter on page {page_num}")
            
            # 3. Export only that page to PDF
            # wdExportFromTo = 3
            # wdExportFormatPDF = 17
            doc.ExportAsFixedFormat(
                OutputFileName=output_pdf_path,
                ExportFormat=17, # wdExportFormatPDF
                Range=3, # wdExportFromTo
                From=page_num,
                To=page_num
            )
            print(f"Exported page {page_num} to {output_pdf_path}")
        else:
            print("Could not find the authorization letter text in the document.")
            
        doc.Close(False)
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        word.Quit()

if __name__ == "__main__":
    abs_doc_path = r"f:\Git_repo\SUEPTeX\模板.docx"
    abs_output_path = r"f:\Git_repo\SUEPTeX\auth.pdf"
    
    if os.path.exists(abs_doc_path):
        process_word_doc(abs_doc_path, abs_output_path)
    else:
        print(f"File not found: {abs_doc_path}")
