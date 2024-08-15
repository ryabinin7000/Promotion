namespace Promotion
{
    partial class ChampForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ChampForm));
            this.champGridView = new System.Windows.Forms.DataGridView();
            this.champCode = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.champFio = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.champWeight = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.champDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.buttonChampUpdate = new System.Windows.Forms.Button();
            this.buttonChampExit = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.champGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // champGridView
            // 
            this.champGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.champGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.champCode,
            this.champFio,
            this.champWeight,
            this.champDate});
            this.champGridView.Location = new System.Drawing.Point(12, 12);
            this.champGridView.Name = "champGridView";
            this.champGridView.RowHeadersWidth = 51;
            this.champGridView.RowTemplate.Height = 24;
            this.champGridView.Size = new System.Drawing.Size(699, 266);
            this.champGridView.TabIndex = 0;
            // 
            // champCode
            // 
            this.champCode.HeaderText = "Код чемпиона";
            this.champCode.MinimumWidth = 6;
            this.champCode.Name = "champCode";
            this.champCode.Width = 60;
            // 
            // champFio
            // 
            this.champFio.HeaderText = "ФИО";
            this.champFio.MinimumWidth = 6;
            this.champFio.Name = "champFio";
            this.champFio.Width = 205;
            // 
            // champWeight
            // 
            this.champWeight.HeaderText = "Весовая категория";
            this.champWeight.MinimumWidth = 6;
            this.champWeight.Name = "champWeight";
            this.champWeight.Width = 125;
            // 
            // champDate
            // 
            this.champDate.HeaderText = "Дата завоевания / защиты";
            this.champDate.MinimumWidth = 6;
            this.champDate.Name = "champDate";
            this.champDate.Width = 80;
            // 
            // buttonChampUpdate
            // 
            this.buttonChampUpdate.Location = new System.Drawing.Point(246, 297);
            this.buttonChampUpdate.Name = "buttonChampUpdate";
            this.buttonChampUpdate.Size = new System.Drawing.Size(105, 48);
            this.buttonChampUpdate.TabIndex = 1;
            this.buttonChampUpdate.Text = "Обновить";
            this.buttonChampUpdate.UseVisualStyleBackColor = true;
            this.buttonChampUpdate.Click += new System.EventHandler(this.buttonChampUpdate_Click);
            // 
            // buttonChampExit
            // 
            this.buttonChampExit.Location = new System.Drawing.Point(389, 297);
            this.buttonChampExit.Name = "buttonChampExit";
            this.buttonChampExit.Size = new System.Drawing.Size(105, 48);
            this.buttonChampExit.TabIndex = 2;
            this.buttonChampExit.Text = "Закрыть";
            this.buttonChampExit.UseVisualStyleBackColor = true;
            this.buttonChampExit.Click += new System.EventHandler(this.buttonChampExit_Click);
            // 
            // ChampForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(723, 359);
            this.Controls.Add(this.buttonChampExit);
            this.Controls.Add(this.buttonChampUpdate);
            this.Controls.Add(this.champGridView);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "ChampForm";
            this.Text = "Чемпионы";
            this.Load += new System.EventHandler(this.ChampForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.champGridView)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView champGridView;
        private System.Windows.Forms.Button buttonChampUpdate;
        private System.Windows.Forms.Button buttonChampExit;
        private System.Windows.Forms.DataGridViewTextBoxColumn champCode;
        private System.Windows.Forms.DataGridViewTextBoxColumn champFio;
        private System.Windows.Forms.DataGridViewTextBoxColumn champWeight;
        private System.Windows.Forms.DataGridViewTextBoxColumn champDate;
    }
}