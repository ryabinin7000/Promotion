namespace Promotion
{
    partial class deleteForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(deleteForm));
            this.labelDelete = new System.Windows.Forms.Label();
            this.buttonDelYes = new System.Windows.Forms.Button();
            this.buttonDelNo = new System.Windows.Forms.Button();
            this.buttonDelCancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // labelDelete
            // 
            this.labelDelete.Location = new System.Drawing.Point(28, 27);
            this.labelDelete.Name = "labelDelete";
            this.labelDelete.Size = new System.Drawing.Size(375, 38);
            this.labelDelete.TabIndex = 0;
            this.labelDelete.Text = "Вы действительно хотите удалить выбранные объекты? Отменить это действие будет не" +
    "возможно";
            this.labelDelete.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // buttonDelYes
            // 
            this.buttonDelYes.Location = new System.Drawing.Point(31, 86);
            this.buttonDelYes.Name = "buttonDelYes";
            this.buttonDelYes.Size = new System.Drawing.Size(96, 42);
            this.buttonDelYes.TabIndex = 1;
            this.buttonDelYes.Text = "Да";
            this.buttonDelYes.UseVisualStyleBackColor = true;
            this.buttonDelYes.Click += new System.EventHandler(this.buttonDelYes_Click);
            // 
            // buttonDelNo
            // 
            this.buttonDelNo.Location = new System.Drawing.Point(155, 86);
            this.buttonDelNo.Name = "buttonDelNo";
            this.buttonDelNo.Size = new System.Drawing.Size(96, 42);
            this.buttonDelNo.TabIndex = 2;
            this.buttonDelNo.Text = "Нет";
            this.buttonDelNo.UseVisualStyleBackColor = true;
            this.buttonDelNo.Click += new System.EventHandler(this.buttonDelNo_Click);
            // 
            // buttonDelCancel
            // 
            this.buttonDelCancel.Location = new System.Drawing.Point(284, 86);
            this.buttonDelCancel.Name = "buttonDelCancel";
            this.buttonDelCancel.Size = new System.Drawing.Size(96, 42);
            this.buttonDelCancel.TabIndex = 3;
            this.buttonDelCancel.Text = "Отмена";
            this.buttonDelCancel.UseVisualStyleBackColor = true;
            this.buttonDelCancel.Click += new System.EventHandler(this.buttonDelCancel_Click);
            // 
            // deleteForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(435, 156);
            this.Controls.Add(this.buttonDelCancel);
            this.Controls.Add(this.buttonDelNo);
            this.Controls.Add(this.buttonDelYes);
            this.Controls.Add(this.labelDelete);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "deleteForm";
            this.Text = "Подтверждение";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label labelDelete;
        private System.Windows.Forms.Button buttonDelYes;
        private System.Windows.Forms.Button buttonDelNo;
        private System.Windows.Forms.Button buttonDelCancel;
    }
}