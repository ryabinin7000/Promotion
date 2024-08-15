namespace Promotion
{
    partial class ContractForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ContractForm));
            this.contractGridView = new System.Windows.Forms.DataGridView();
            this.buttonContractUpdate = new System.Windows.Forms.Button();
            this.buttonContractExit = new System.Windows.Forms.Button();
            this.contractNumber = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractCode = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractFio = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractSeniority = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractFights = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractFee = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractSalary = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractCompen = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractMin = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractSignDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.contractEndDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.contractGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // contractGridView
            // 
            this.contractGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.contractGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.contractNumber,
            this.contractCode,
            this.contractFio,
            this.contractSeniority,
            this.contractFights,
            this.contractFee,
            this.contractSalary,
            this.contractCompen,
            this.contractMin,
            this.contractSignDate,
            this.contractEndDate});
            this.contractGridView.Location = new System.Drawing.Point(12, 12);
            this.contractGridView.Name = "contractGridView";
            this.contractGridView.RowHeadersWidth = 51;
            this.contractGridView.RowTemplate.Height = 24;
            this.contractGridView.Size = new System.Drawing.Size(976, 455);
            this.contractGridView.TabIndex = 0;
            // 
            // buttonContractUpdate
            // 
            this.buttonContractUpdate.Location = new System.Drawing.Point(391, 482);
            this.buttonContractUpdate.Name = "buttonContractUpdate";
            this.buttonContractUpdate.Size = new System.Drawing.Size(111, 42);
            this.buttonContractUpdate.TabIndex = 1;
            this.buttonContractUpdate.Text = "Обновить";
            this.buttonContractUpdate.UseVisualStyleBackColor = true;
            this.buttonContractUpdate.Click += new System.EventHandler(this.buttonContractUpdate_Click);
            // 
            // buttonContractExit
            // 
            this.buttonContractExit.Location = new System.Drawing.Point(530, 482);
            this.buttonContractExit.Name = "buttonContractExit";
            this.buttonContractExit.Size = new System.Drawing.Size(111, 42);
            this.buttonContractExit.TabIndex = 2;
            this.buttonContractExit.Text = "Закрыть";
            this.buttonContractExit.UseVisualStyleBackColor = true;
            this.buttonContractExit.Click += new System.EventHandler(this.buttonContractExit_Click);
            // 
            // contractNumber
            // 
            this.contractNumber.HeaderText = "Номер";
            this.contractNumber.MinimumWidth = 6;
            this.contractNumber.Name = "contractNumber";
            this.contractNumber.Width = 80;
            // 
            // contractCode
            // 
            this.contractCode.HeaderText = "Код бойца";
            this.contractCode.MinimumWidth = 6;
            this.contractCode.Name = "contractCode";
            this.contractCode.Width = 50;
            // 
            // contractFio
            // 
            this.contractFio.HeaderText = "ФИО";
            this.contractFio.MinimumWidth = 6;
            this.contractFio.Name = "contractFio";
            this.contractFio.Width = 180;
            // 
            // contractSeniority
            // 
            this.contractSeniority.HeaderText = "Стаж";
            this.contractSeniority.MinimumWidth = 6;
            this.contractSeniority.Name = "contractSeniority";
            this.contractSeniority.Width = 40;
            // 
            // contractFights
            // 
            this.contractFights.HeaderText = "Количество поединков";
            this.contractFights.MinimumWidth = 6;
            this.contractFights.Name = "contractFights";
            this.contractFights.Width = 70;
            // 
            // contractFee
            // 
            this.contractFee.HeaderText = "Гонорар (руб)";
            this.contractFee.MinimumWidth = 6;
            this.contractFee.Name = "contractFee";
            this.contractFee.Width = 80;
            // 
            // contractSalary
            // 
            this.contractSalary.HeaderText = "Зарплата (руб)";
            this.contractSalary.MinimumWidth = 6;
            this.contractSalary.Name = "contractSalary";
            this.contractSalary.Width = 80;
            // 
            // contractCompen
            // 
            this.contractCompen.HeaderText = "Компенсация (руб)";
            this.contractCompen.MinimumWidth = 6;
            this.contractCompen.Name = "contractCompen";
            this.contractCompen.Width = 80;
            // 
            // contractMin
            // 
            this.contractMin.HeaderText = "Минимальные выплаты (руб)";
            this.contractMin.MinimumWidth = 6;
            this.contractMin.Name = "contractMin";
            this.contractMin.Width = 90;
            // 
            // contractSignDate
            // 
            this.contractSignDate.HeaderText = "Дата подписания";
            this.contractSignDate.MinimumWidth = 6;
            this.contractSignDate.Name = "contractSignDate";
            this.contractSignDate.Width = 70;
            // 
            // contractEndDate
            // 
            this.contractEndDate.HeaderText = "Дата окончания";
            this.contractEndDate.MinimumWidth = 6;
            this.contractEndDate.Name = "contractEndDate";
            this.contractEndDate.Width = 70;
            // 
            // ContractForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1000, 536);
            this.Controls.Add(this.buttonContractExit);
            this.Controls.Add(this.buttonContractUpdate);
            this.Controls.Add(this.contractGridView);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "ContractForm";
            this.Text = "Действующие контракты";
            this.Load += new System.EventHandler(this.ContractForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.contractGridView)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView contractGridView;
        private System.Windows.Forms.Button buttonContractUpdate;
        private System.Windows.Forms.Button buttonContractExit;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractNumber;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractCode;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractFio;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractSeniority;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractFights;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractFee;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractSalary;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractCompen;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractMin;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractSignDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn contractEndDate;
    }
}