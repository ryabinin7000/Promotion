namespace Promotion
{
    partial class EventForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(EventForm));
            this.labelName = new System.Windows.Forms.Label();
            this.labelArena = new System.Windows.Forms.Label();
            this.labelEventDate = new System.Windows.Forms.Label();
            this.labelAttend = new System.Windows.Forms.Label();
            this.labelRevenue = new System.Windows.Forms.Label();
            this.labelCosts = new System.Windows.Forms.Label();
            this.textBoxName = new System.Windows.Forms.TextBox();
            this.comboBoxArenas = new System.Windows.Forms.ComboBox();
            this.dateTimePickerEvent = new System.Windows.Forms.DateTimePicker();
            this.textBoxAttend = new System.Windows.Forms.TextBox();
            this.textBoxRevenue = new System.Windows.Forms.TextBox();
            this.textBoxCosts = new System.Windows.Forms.TextBox();
            this.buttonEventSend = new System.Windows.Forms.Button();
            this.buttonEventCancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // labelName
            // 
            this.labelName.AutoSize = true;
            this.labelName.Location = new System.Drawing.Point(102, 9);
            this.labelName.Name = "labelName";
            this.labelName.Size = new System.Drawing.Size(73, 16);
            this.labelName.TabIndex = 0;
            this.labelName.Text = "Название";
            // 
            // labelArena
            // 
            this.labelArena.AutoSize = true;
            this.labelArena.Location = new System.Drawing.Point(73, 68);
            this.labelArena.Name = "labelArena";
            this.labelArena.Size = new System.Drawing.Size(130, 16);
            this.labelArena.TabIndex = 1;
            this.labelArena.Text = "Место проведения";
            // 
            // labelEventDate
            // 
            this.labelEventDate.AutoSize = true;
            this.labelEventDate.Location = new System.Drawing.Point(384, 9);
            this.labelEventDate.Name = "labelEventDate";
            this.labelEventDate.Size = new System.Drawing.Size(39, 16);
            this.labelEventDate.TabIndex = 2;
            this.labelEventDate.Text = "Дата";
            // 
            // labelAttend
            // 
            this.labelAttend.AutoSize = true;
            this.labelAttend.Location = new System.Drawing.Point(337, 68);
            this.labelAttend.Name = "labelAttend";
            this.labelAttend.Size = new System.Drawing.Size(138, 16);
            this.labelAttend.TabIndex = 3;
            this.labelAttend.Text = "Посещаемость (чел)";
            // 
            // labelRevenue
            // 
            this.labelRevenue.AutoSize = true;
            this.labelRevenue.Location = new System.Drawing.Point(60, 123);
            this.labelRevenue.Name = "labelRevenue";
            this.labelRevenue.Size = new System.Drawing.Size(143, 16);
            this.labelRevenue.TabIndex = 4;
            this.labelRevenue.Text = "Общая выручка (руб)";
            // 
            // labelCosts
            // 
            this.labelCosts.AutoSize = true;
            this.labelCosts.Location = new System.Drawing.Point(297, 123);
            this.labelCosts.Name = "labelCosts";
            this.labelCosts.Size = new System.Drawing.Size(208, 16);
            this.labelCosts.TabIndex = 5;
            this.labelCosts.Text = "Затраты на организацию (руб)";
            // 
            // textBoxName
            // 
            this.textBoxName.Location = new System.Drawing.Point(12, 31);
            this.textBoxName.Name = "textBoxName";
            this.textBoxName.Size = new System.Drawing.Size(262, 22);
            this.textBoxName.TabIndex = 6;
            // 
            // comboBoxArenas
            // 
            this.comboBoxArenas.FormattingEnabled = true;
            this.comboBoxArenas.Location = new System.Drawing.Point(12, 87);
            this.comboBoxArenas.Name = "comboBoxArenas";
            this.comboBoxArenas.Size = new System.Drawing.Size(262, 24);
            this.comboBoxArenas.TabIndex = 7;
            // 
            // dateTimePickerEvent
            // 
            this.dateTimePickerEvent.Location = new System.Drawing.Point(305, 31);
            this.dateTimePickerEvent.MinDate = new System.DateTime(1990, 1, 1, 0, 0, 0, 0);
            this.dateTimePickerEvent.Name = "dateTimePickerEvent";
            this.dateTimePickerEvent.Size = new System.Drawing.Size(200, 22);
            this.dateTimePickerEvent.TabIndex = 8;
            // 
            // textBoxAttend
            // 
            this.textBoxAttend.Location = new System.Drawing.Point(353, 87);
            this.textBoxAttend.Name = "textBoxAttend";
            this.textBoxAttend.Size = new System.Drawing.Size(100, 22);
            this.textBoxAttend.TabIndex = 9;
            // 
            // textBoxRevenue
            // 
            this.textBoxRevenue.Location = new System.Drawing.Point(63, 142);
            this.textBoxRevenue.Name = "textBoxRevenue";
            this.textBoxRevenue.Size = new System.Drawing.Size(140, 22);
            this.textBoxRevenue.TabIndex = 10;
            // 
            // textBoxCosts
            // 
            this.textBoxCosts.Location = new System.Drawing.Point(340, 142);
            this.textBoxCosts.Name = "textBoxCosts";
            this.textBoxCosts.Size = new System.Drawing.Size(128, 22);
            this.textBoxCosts.TabIndex = 11;
            // 
            // buttonEventSend
            // 
            this.buttonEventSend.Location = new System.Drawing.Point(140, 189);
            this.buttonEventSend.Name = "buttonEventSend";
            this.buttonEventSend.Size = new System.Drawing.Size(101, 35);
            this.buttonEventSend.TabIndex = 12;
            this.buttonEventSend.Text = "Отправить";
            this.buttonEventSend.UseVisualStyleBackColor = true;
            this.buttonEventSend.Click += new System.EventHandler(this.buttonEventSend_Click);
            // 
            // buttonEventCancel
            // 
            this.buttonEventCancel.Location = new System.Drawing.Point(279, 188);
            this.buttonEventCancel.Name = "buttonEventCancel";
            this.buttonEventCancel.Size = new System.Drawing.Size(99, 36);
            this.buttonEventCancel.TabIndex = 13;
            this.buttonEventCancel.Text = "Отмена";
            this.buttonEventCancel.UseVisualStyleBackColor = true;
            this.buttonEventCancel.Click += new System.EventHandler(this.buttonEventCancel_Click);
            // 
            // EventForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(527, 239);
            this.Controls.Add(this.buttonEventCancel);
            this.Controls.Add(this.buttonEventSend);
            this.Controls.Add(this.textBoxCosts);
            this.Controls.Add(this.textBoxRevenue);
            this.Controls.Add(this.textBoxAttend);
            this.Controls.Add(this.dateTimePickerEvent);
            this.Controls.Add(this.comboBoxArenas);
            this.Controls.Add(this.textBoxName);
            this.Controls.Add(this.labelCosts);
            this.Controls.Add(this.labelRevenue);
            this.Controls.Add(this.labelAttend);
            this.Controls.Add(this.labelEventDate);
            this.Controls.Add(this.labelArena);
            this.Controls.Add(this.labelName);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "EventForm";
            this.Text = "Редактирование информации о турнире";
            this.Load += new System.EventHandler(this.EventForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelName;
        private System.Windows.Forms.Label labelArena;
        private System.Windows.Forms.Label labelEventDate;
        private System.Windows.Forms.Label labelAttend;
        private System.Windows.Forms.Label labelRevenue;
        private System.Windows.Forms.Label labelCosts;
        private System.Windows.Forms.TextBox textBoxName;
        private System.Windows.Forms.ComboBox comboBoxArenas;
        private System.Windows.Forms.DateTimePicker dateTimePickerEvent;
        private System.Windows.Forms.TextBox textBoxAttend;
        private System.Windows.Forms.TextBox textBoxRevenue;
        private System.Windows.Forms.TextBox textBoxCosts;
        private System.Windows.Forms.Button buttonEventSend;
        private System.Windows.Forms.Button buttonEventCancel;
    }
}