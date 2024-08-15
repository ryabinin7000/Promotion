namespace Promotion
{
    partial class FightForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FightForm));
            this.fio1Label = new System.Windows.Forms.Label();
            this.fio2Label = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.labelFightWeight = new System.Windows.Forms.Label();
            this.labelWinner = new System.Windows.Forms.Label();
            this.labelEventNumber = new System.Windows.Forms.Label();
            this.labelResult = new System.Windows.Forms.Label();
            this.labelRound = new System.Windows.Forms.Label();
            this.labelTime = new System.Windows.Forms.Label();
            this.fightsPanel1 = new System.Windows.Forms.Panel();
            this.checkBoxResult = new System.Windows.Forms.CheckBox();
            this.checkBoxChamp = new System.Windows.Forms.CheckBox();
            this.numericUpDownEventNumber = new System.Windows.Forms.NumericUpDown();
            this.comboBoxWeight = new System.Windows.Forms.ComboBox();
            this.comboBoxEvent = new System.Windows.Forms.ComboBox();
            this.fio2ComboBox = new System.Windows.Forms.ComboBox();
            this.fio1ComboBox = new System.Windows.Forms.ComboBox();
            this.fightsPanel2 = new System.Windows.Forms.Panel();
            this.textBoxTime = new System.Windows.Forms.TextBox();
            this.numericUpDownRound = new System.Windows.Forms.NumericUpDown();
            this.comboBoxResult = new System.Windows.Forms.ComboBox();
            this.comboBoxWinner = new System.Windows.Forms.ComboBox();
            this.buttonFightSend = new System.Windows.Forms.Button();
            this.buttonFightCancel = new System.Windows.Forms.Button();
            this.fightsPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownEventNumber)).BeginInit();
            this.fightsPanel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownRound)).BeginInit();
            this.SuspendLayout();
            // 
            // fio1Label
            // 
            this.fio1Label.AutoSize = true;
            this.fio1Label.Location = new System.Drawing.Point(65, 12);
            this.fio1Label.Name = "fio1Label";
            this.fio1Label.Size = new System.Drawing.Size(93, 16);
            this.fio1Label.TabIndex = 0;
            this.fio1Label.Text = "Первый боец";
            // 
            // fio2Label
            // 
            this.fio2Label.AutoSize = true;
            this.fio2Label.Location = new System.Drawing.Point(320, 12);
            this.fio2Label.Name = "fio2Label";
            this.fio2Label.Size = new System.Drawing.Size(90, 16);
            this.fio2Label.TabIndex = 1;
            this.fio2Label.Text = "Второй боец";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(85, 79);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 16);
            this.label3.TabIndex = 2;
            this.label3.Text = "Турнир";
            // 
            // labelFightWeight
            // 
            this.labelFightWeight.AutoSize = true;
            this.labelFightWeight.Location = new System.Drawing.Point(298, 79);
            this.labelFightWeight.Name = "labelFightWeight";
            this.labelFightWeight.Size = new System.Drawing.Size(132, 16);
            this.labelFightWeight.TabIndex = 3;
            this.labelFightWeight.Text = "Весовая категория";
            // 
            // labelWinner
            // 
            this.labelWinner.AutoSize = true;
            this.labelWinner.Location = new System.Drawing.Point(65, 11);
            this.labelWinner.Name = "labelWinner";
            this.labelWinner.Size = new System.Drawing.Size(87, 16);
            this.labelWinner.TabIndex = 4;
            this.labelWinner.Text = "Победитель";
            // 
            // labelEventNumber
            // 
            this.labelEventNumber.AutoSize = true;
            this.labelEventNumber.Location = new System.Drawing.Point(55, 149);
            this.labelEventNumber.Name = "labelEventNumber";
            this.labelEventNumber.Size = new System.Drawing.Size(119, 16);
            this.labelEventNumber.TabIndex = 5;
            this.labelEventNumber.Text = "Номер в турнире";
            // 
            // labelResult
            // 
            this.labelResult.AutoSize = true;
            this.labelResult.Location = new System.Drawing.Point(320, 11);
            this.labelResult.Name = "labelResult";
            this.labelResult.Size = new System.Drawing.Size(77, 16);
            this.labelResult.TabIndex = 6;
            this.labelResult.Text = "Результат";
            // 
            // labelRound
            // 
            this.labelRound.AutoSize = true;
            this.labelRound.Location = new System.Drawing.Point(85, 76);
            this.labelRound.Name = "labelRound";
            this.labelRound.Size = new System.Drawing.Size(48, 16);
            this.labelRound.TabIndex = 7;
            this.labelRound.Text = "Раунд";
            // 
            // labelTime
            // 
            this.labelTime.AutoSize = true;
            this.labelTime.Location = new System.Drawing.Point(332, 76);
            this.labelTime.Name = "labelTime";
            this.labelTime.Size = new System.Drawing.Size(48, 16);
            this.labelTime.TabIndex = 8;
            this.labelTime.Text = "Время";
            // 
            // fightsPanel1
            // 
            this.fightsPanel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.fightsPanel1.Controls.Add(this.checkBoxResult);
            this.fightsPanel1.Controls.Add(this.checkBoxChamp);
            this.fightsPanel1.Controls.Add(this.numericUpDownEventNumber);
            this.fightsPanel1.Controls.Add(this.comboBoxWeight);
            this.fightsPanel1.Controls.Add(this.comboBoxEvent);
            this.fightsPanel1.Controls.Add(this.fio2ComboBox);
            this.fightsPanel1.Controls.Add(this.fio1ComboBox);
            this.fightsPanel1.Controls.Add(this.fio1Label);
            this.fightsPanel1.Controls.Add(this.fio2Label);
            this.fightsPanel1.Controls.Add(this.label3);
            this.fightsPanel1.Controls.Add(this.labelFightWeight);
            this.fightsPanel1.Controls.Add(this.labelEventNumber);
            this.fightsPanel1.Location = new System.Drawing.Point(12, 12);
            this.fightsPanel1.Name = "fightsPanel1";
            this.fightsPanel1.Size = new System.Drawing.Size(486, 212);
            this.fightsPanel1.TabIndex = 12;
            // 
            // checkBoxResult
            // 
            this.checkBoxResult.AutoSize = true;
            this.checkBoxResult.Checked = true;
            this.checkBoxResult.CheckState = System.Windows.Forms.CheckState.Checked;
            this.checkBoxResult.Location = new System.Drawing.Point(258, 171);
            this.checkBoxResult.Name = "checkBoxResult";
            this.checkBoxResult.Size = new System.Drawing.Size(190, 20);
            this.checkBoxResult.TabIndex = 10;
            this.checkBoxResult.Text = "Результат боя известен";
            this.checkBoxResult.UseVisualStyleBackColor = true;
            this.checkBoxResult.CheckedChanged += new System.EventHandler(this.checkBoxResult_CheckedChanged);
            // 
            // checkBoxChamp
            // 
            this.checkBoxChamp.AutoSize = true;
            this.checkBoxChamp.Location = new System.Drawing.Point(258, 145);
            this.checkBoxChamp.Name = "checkBoxChamp";
            this.checkBoxChamp.Size = new System.Drawing.Size(183, 20);
            this.checkBoxChamp.TabIndex = 9;
            this.checkBoxChamp.Text = "Чемпионский поединок";
            this.checkBoxChamp.UseVisualStyleBackColor = true;
            // 
            // numericUpDownEventNumber
            // 
            this.numericUpDownEventNumber.Location = new System.Drawing.Point(13, 168);
            this.numericUpDownEventNumber.Maximum = new decimal(new int[] {
            18,
            0,
            0,
            0});
            this.numericUpDownEventNumber.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numericUpDownEventNumber.Name = "numericUpDownEventNumber";
            this.numericUpDownEventNumber.Size = new System.Drawing.Size(207, 22);
            this.numericUpDownEventNumber.TabIndex = 8;
            this.numericUpDownEventNumber.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // comboBoxWeight
            // 
            this.comboBoxWeight.FormattingEnabled = true;
            this.comboBoxWeight.Location = new System.Drawing.Point(258, 100);
            this.comboBoxWeight.Name = "comboBoxWeight";
            this.comboBoxWeight.Size = new System.Drawing.Size(208, 24);
            this.comboBoxWeight.TabIndex = 7;
            // 
            // comboBoxEvent
            // 
            this.comboBoxEvent.FormattingEnabled = true;
            this.comboBoxEvent.Location = new System.Drawing.Point(13, 100);
            this.comboBoxEvent.Name = "comboBoxEvent";
            this.comboBoxEvent.Size = new System.Drawing.Size(207, 24);
            this.comboBoxEvent.TabIndex = 6;
            // 
            // fio2ComboBox
            // 
            this.fio2ComboBox.FormattingEnabled = true;
            this.fio2ComboBox.Location = new System.Drawing.Point(258, 31);
            this.fio2ComboBox.Name = "fio2ComboBox";
            this.fio2ComboBox.Size = new System.Drawing.Size(208, 24);
            this.fio2ComboBox.TabIndex = 3;
            // 
            // fio1ComboBox
            // 
            this.fio1ComboBox.FormattingEnabled = true;
            this.fio1ComboBox.Location = new System.Drawing.Point(13, 31);
            this.fio1ComboBox.Name = "fio1ComboBox";
            this.fio1ComboBox.Size = new System.Drawing.Size(207, 24);
            this.fio1ComboBox.TabIndex = 2;
            // 
            // fightsPanel2
            // 
            this.fightsPanel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.fightsPanel2.Controls.Add(this.textBoxTime);
            this.fightsPanel2.Controls.Add(this.numericUpDownRound);
            this.fightsPanel2.Controls.Add(this.comboBoxResult);
            this.fightsPanel2.Controls.Add(this.comboBoxWinner);
            this.fightsPanel2.Controls.Add(this.labelWinner);
            this.fightsPanel2.Controls.Add(this.labelResult);
            this.fightsPanel2.Controls.Add(this.labelRound);
            this.fightsPanel2.Controls.Add(this.labelTime);
            this.fightsPanel2.Location = new System.Drawing.Point(12, 242);
            this.fightsPanel2.Name = "fightsPanel2";
            this.fightsPanel2.Size = new System.Drawing.Size(486, 133);
            this.fightsPanel2.TabIndex = 13;
            // 
            // textBoxTime
            // 
            this.textBoxTime.Location = new System.Drawing.Point(258, 95);
            this.textBoxTime.Name = "textBoxTime";
            this.textBoxTime.Size = new System.Drawing.Size(208, 22);
            this.textBoxTime.TabIndex = 12;
            // 
            // numericUpDownRound
            // 
            this.numericUpDownRound.Location = new System.Drawing.Point(13, 95);
            this.numericUpDownRound.Maximum = new decimal(new int[] {
            5,
            0,
            0,
            0});
            this.numericUpDownRound.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numericUpDownRound.Name = "numericUpDownRound";
            this.numericUpDownRound.Size = new System.Drawing.Size(207, 22);
            this.numericUpDownRound.TabIndex = 11;
            this.numericUpDownRound.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // comboBoxResult
            // 
            this.comboBoxResult.FormattingEnabled = true;
            this.comboBoxResult.Location = new System.Drawing.Point(258, 30);
            this.comboBoxResult.Name = "comboBoxResult";
            this.comboBoxResult.Size = new System.Drawing.Size(208, 24);
            this.comboBoxResult.TabIndex = 10;
            // 
            // comboBoxWinner
            // 
            this.comboBoxWinner.FormattingEnabled = true;
            this.comboBoxWinner.Location = new System.Drawing.Point(13, 30);
            this.comboBoxWinner.Name = "comboBoxWinner";
            this.comboBoxWinner.Size = new System.Drawing.Size(207, 24);
            this.comboBoxWinner.TabIndex = 9;
            // 
            // buttonFightSend
            // 
            this.buttonFightSend.Location = new System.Drawing.Point(117, 395);
            this.buttonFightSend.Name = "buttonFightSend";
            this.buttonFightSend.Size = new System.Drawing.Size(116, 40);
            this.buttonFightSend.TabIndex = 14;
            this.buttonFightSend.Text = "Отправить";
            this.buttonFightSend.UseVisualStyleBackColor = true;
            this.buttonFightSend.Click += new System.EventHandler(this.buttonFightSend_Click);
            // 
            // buttonFightCancel
            // 
            this.buttonFightCancel.Location = new System.Drawing.Point(271, 395);
            this.buttonFightCancel.Name = "buttonFightCancel";
            this.buttonFightCancel.Size = new System.Drawing.Size(116, 40);
            this.buttonFightCancel.TabIndex = 15;
            this.buttonFightCancel.Text = "Отмена";
            this.buttonFightCancel.UseVisualStyleBackColor = true;
            this.buttonFightCancel.Click += new System.EventHandler(this.buttonFightCancel_Click);
            // 
            // FightForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(515, 455);
            this.Controls.Add(this.buttonFightCancel);
            this.Controls.Add(this.buttonFightSend);
            this.Controls.Add(this.fightsPanel2);
            this.Controls.Add(this.fightsPanel1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "FightForm";
            this.Text = "Редактирование информации о поединке";
            this.Load += new System.EventHandler(this.FightForm_Load);
            this.fightsPanel1.ResumeLayout(false);
            this.fightsPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownEventNumber)).EndInit();
            this.fightsPanel2.ResumeLayout(false);
            this.fightsPanel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.numericUpDownRound)).EndInit();
            this.ResumeLayout(false);

        }

        private void CheckBoxChamp_CheckedChanged(object sender, System.EventArgs e)
        {
            throw new System.NotImplementedException();
        }

        #endregion

        private System.Windows.Forms.Label fio1Label;
        private System.Windows.Forms.Label fio2Label;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label labelFightWeight;
        private System.Windows.Forms.Label labelWinner;
        private System.Windows.Forms.Label labelEventNumber;
        private System.Windows.Forms.Label labelResult;
        private System.Windows.Forms.Label labelRound;
        private System.Windows.Forms.Label labelTime;
        private System.Windows.Forms.Panel fightsPanel1;
        private System.Windows.Forms.ComboBox fio1ComboBox;
        private System.Windows.Forms.Panel fightsPanel2;
        private System.Windows.Forms.ComboBox fio2ComboBox;
        private System.Windows.Forms.NumericUpDown numericUpDownEventNumber;
        private System.Windows.Forms.ComboBox comboBoxWeight;
        private System.Windows.Forms.ComboBox comboBoxEvent;
        private System.Windows.Forms.CheckBox checkBoxChamp;
        private System.Windows.Forms.CheckBox checkBoxResult;
        private System.Windows.Forms.NumericUpDown numericUpDownRound;
        private System.Windows.Forms.ComboBox comboBoxResult;
        private System.Windows.Forms.ComboBox comboBoxWinner;
        private System.Windows.Forms.TextBox textBoxTime;
        private System.Windows.Forms.Button buttonFightSend;
        private System.Windows.Forms.Button buttonFightCancel;
    }
}