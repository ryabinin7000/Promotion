namespace Promotion
{
    partial class AwardsForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(AwardsForm));
            this.awardsGridView = new System.Windows.Forms.DataGridView();
            this.buttonAwardUpdate = new System.Windows.Forms.Button();
            this.buttonAwardExit = new System.Windows.Forms.Button();
            this.awardNumber = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.awardFio1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.awardFio2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.awardEvent = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.awardDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.awardName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.awardAwarded = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.awardMoney = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.awardsGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // awardsGridView
            // 
            this.awardsGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.awardsGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.awardNumber,
            this.awardFio1,
            this.awardFio2,
            this.awardEvent,
            this.awardDate,
            this.awardName,
            this.awardAwarded,
            this.awardMoney});
            this.awardsGridView.Location = new System.Drawing.Point(12, 12);
            this.awardsGridView.Name = "awardsGridView";
            this.awardsGridView.RowHeadersWidth = 51;
            this.awardsGridView.RowTemplate.Height = 24;
            this.awardsGridView.Size = new System.Drawing.Size(1002, 395);
            this.awardsGridView.TabIndex = 0;
            // 
            // buttonAwardUpdate
            // 
            this.buttonAwardUpdate.Location = new System.Drawing.Point(412, 423);
            this.buttonAwardUpdate.Name = "buttonAwardUpdate";
            this.buttonAwardUpdate.Size = new System.Drawing.Size(106, 42);
            this.buttonAwardUpdate.TabIndex = 1;
            this.buttonAwardUpdate.Text = "Обновить";
            this.buttonAwardUpdate.UseVisualStyleBackColor = true;
            this.buttonAwardUpdate.Click += new System.EventHandler(this.buttonAwardUpdate_Click);
            // 
            // buttonAwardExit
            // 
            this.buttonAwardExit.Location = new System.Drawing.Point(553, 423);
            this.buttonAwardExit.Name = "buttonAwardExit";
            this.buttonAwardExit.Size = new System.Drawing.Size(106, 42);
            this.buttonAwardExit.TabIndex = 2;
            this.buttonAwardExit.Text = "Закрыть";
            this.buttonAwardExit.UseVisualStyleBackColor = true;
            this.buttonAwardExit.Click += new System.EventHandler(this.buttonAwardExit_Click);
            // 
            // awardNumber
            // 
            this.awardNumber.HeaderText = "Номер поединка";
            this.awardNumber.MinimumWidth = 6;
            this.awardNumber.Name = "awardNumber";
            this.awardNumber.Width = 60;
            // 
            // awardFio1
            // 
            this.awardFio1.HeaderText = "Боец 1";
            this.awardFio1.MinimumWidth = 6;
            this.awardFio1.Name = "awardFio1";
            this.awardFio1.Width = 125;
            // 
            // awardFio2
            // 
            this.awardFio2.HeaderText = "Боец 2";
            this.awardFio2.MinimumWidth = 6;
            this.awardFio2.Name = "awardFio2";
            this.awardFio2.Width = 125;
            // 
            // awardEvent
            // 
            this.awardEvent.HeaderText = "Турнир";
            this.awardEvent.MinimumWidth = 6;
            this.awardEvent.Name = "awardEvent";
            this.awardEvent.Width = 125;
            // 
            // awardDate
            // 
            this.awardDate.HeaderText = "Дата";
            this.awardDate.MinimumWidth = 6;
            this.awardDate.Name = "awardDate";
            this.awardDate.Width = 80;
            // 
            // awardName
            // 
            this.awardName.HeaderText = "Награда";
            this.awardName.MinimumWidth = 6;
            this.awardName.Name = "awardName";
            this.awardName.Width = 125;
            // 
            // awardAwarded
            // 
            this.awardAwarded.HeaderText = "Награжденный боец";
            this.awardAwarded.MinimumWidth = 6;
            this.awardAwarded.Name = "awardAwarded";
            this.awardAwarded.Width = 125;
            // 
            // awardMoney
            // 
            this.awardMoney.HeaderText = "Денежный бонус (руб)";
            this.awardMoney.MinimumWidth = 6;
            this.awardMoney.Name = "awardMoney";
            this.awardMoney.Width = 80;
            // 
            // AwardsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1042, 477);
            this.Controls.Add(this.buttonAwardExit);
            this.Controls.Add(this.buttonAwardUpdate);
            this.Controls.Add(this.awardsGridView);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "AwardsForm";
            this.Text = "Награды за поединки";
            this.Load += new System.EventHandler(this.AwardsForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.awardsGridView)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView awardsGridView;
        private System.Windows.Forms.Button buttonAwardUpdate;
        private System.Windows.Forms.Button buttonAwardExit;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardNumber;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardFio1;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardFio2;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardEvent;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardName;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardAwarded;
        private System.Windows.Forms.DataGridViewTextBoxColumn awardMoney;
    }
}