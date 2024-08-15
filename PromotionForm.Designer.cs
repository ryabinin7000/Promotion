namespace Promotion
{
    partial class PromotionForm
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PromotionForm));
            this.promotionTabControl = new System.Windows.Forms.TabControl();
            this.fightTab = new System.Windows.Forms.TabPage();
            this.fightGridView = new System.Windows.Forms.DataGridView();
            this.fightCode = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fio1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fio2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fightEvent = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fightDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fightWeight = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fightWinner = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fightResult = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.round = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.time = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fightStatus = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fightNumber = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.eventTab = new System.Windows.Forms.TabPage();
            this.eventsGridView = new System.Windows.Forms.DataGridView();
            this.eventName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.eventArena = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.eventDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.attend = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.sold = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.revenue = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cash = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.costs = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.profit = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fighterTab = new System.Windows.Forms.TabPage();
            this.fightersGridView = new System.Windows.Forms.DataGridView();
            this.code = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fio = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.birthDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.country = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.citizenship = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.seniority = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.signDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.endDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.phone = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.email = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.passport = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.address = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.wins = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.losses = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.weight = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.height = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.reach = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.insertButton = new System.Windows.Forms.Button();
            this.updateButton = new System.Windows.Forms.Button();
            this.deleteButton = new System.Windows.Forms.Button();
            this.buttonChamp = new System.Windows.Forms.Button();
            this.buttonContracts = new System.Windows.Forms.Button();
            this.buttonAwards = new System.Windows.Forms.Button();
            this.panelPromotion1 = new System.Windows.Forms.Panel();
            this.panelPromotion2 = new System.Windows.Forms.Panel();
            this.panelPromotion3 = new System.Windows.Forms.Panel();
            this.buttonExit = new System.Windows.Forms.Button();
            this.promotionTabControl.SuspendLayout();
            this.fightTab.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.fightGridView)).BeginInit();
            this.eventTab.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.eventsGridView)).BeginInit();
            this.fighterTab.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.fightersGridView)).BeginInit();
            this.panelPromotion1.SuspendLayout();
            this.panelPromotion2.SuspendLayout();
            this.panelPromotion3.SuspendLayout();
            this.SuspendLayout();
            // 
            // promotionTabControl
            // 
            this.promotionTabControl.Controls.Add(this.fightTab);
            this.promotionTabControl.Controls.Add(this.eventTab);
            this.promotionTabControl.Controls.Add(this.fighterTab);
            this.promotionTabControl.Location = new System.Drawing.Point(12, 12);
            this.promotionTabControl.Name = "promotionTabControl";
            this.promotionTabControl.SelectedIndex = 0;
            this.promotionTabControl.Size = new System.Drawing.Size(997, 449);
            this.promotionTabControl.TabIndex = 0;
            this.promotionTabControl.Selected += new System.Windows.Forms.TabControlEventHandler(this.promotionTabControl_Selected);
            // 
            // fightTab
            // 
            this.fightTab.Controls.Add(this.fightGridView);
            this.fightTab.Location = new System.Drawing.Point(4, 25);
            this.fightTab.Name = "fightTab";
            this.fightTab.Padding = new System.Windows.Forms.Padding(3);
            this.fightTab.Size = new System.Drawing.Size(989, 420);
            this.fightTab.TabIndex = 0;
            this.fightTab.Text = "Поединок";
            this.fightTab.UseVisualStyleBackColor = true;
            // 
            // fightGridView
            // 
            this.fightGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.fightGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.fightCode,
            this.fio1,
            this.fio2,
            this.fightEvent,
            this.fightDate,
            this.fightWeight,
            this.fightWinner,
            this.fightResult,
            this.round,
            this.time,
            this.fightStatus,
            this.fightNumber});
            this.fightGridView.Location = new System.Drawing.Point(7, 6);
            this.fightGridView.Name = "fightGridView";
            this.fightGridView.RowHeadersWidth = 51;
            this.fightGridView.RowTemplate.Height = 24;
            this.fightGridView.Size = new System.Drawing.Size(972, 408);
            this.fightGridView.TabIndex = 0;
            // 
            // fightCode
            // 
            this.fightCode.HeaderText = "Номер";
            this.fightCode.MinimumWidth = 6;
            this.fightCode.Name = "fightCode";
            this.fightCode.Width = 50;
            // 
            // fio1
            // 
            this.fio1.HeaderText = "Первый боец";
            this.fio1.MinimumWidth = 6;
            this.fio1.Name = "fio1";
            this.fio1.Width = 150;
            // 
            // fio2
            // 
            this.fio2.HeaderText = "Второй боец";
            this.fio2.MinimumWidth = 6;
            this.fio2.Name = "fio2";
            this.fio2.Width = 150;
            // 
            // fightEvent
            // 
            this.fightEvent.HeaderText = "Турнир";
            this.fightEvent.MinimumWidth = 6;
            this.fightEvent.Name = "fightEvent";
            this.fightEvent.Width = 125;
            // 
            // fightDate
            // 
            this.fightDate.HeaderText = "Дата";
            this.fightDate.MinimumWidth = 6;
            this.fightDate.Name = "fightDate";
            this.fightDate.Width = 70;
            // 
            // fightWeight
            // 
            this.fightWeight.HeaderText = "Весовая категория";
            this.fightWeight.MinimumWidth = 6;
            this.fightWeight.Name = "fightWeight";
            this.fightWeight.Width = 110;
            // 
            // fightWinner
            // 
            this.fightWinner.HeaderText = "Победитель";
            this.fightWinner.MinimumWidth = 6;
            this.fightWinner.Name = "fightWinner";
            this.fightWinner.Width = 150;
            // 
            // fightResult
            // 
            this.fightResult.HeaderText = "Результат";
            this.fightResult.MinimumWidth = 6;
            this.fightResult.Name = "fightResult";
            this.fightResult.Width = 125;
            // 
            // round
            // 
            this.round.HeaderText = "Раунд";
            this.round.MinimumWidth = 6;
            this.round.Name = "round";
            this.round.Width = 50;
            // 
            // time
            // 
            this.time.HeaderText = "Время";
            this.time.MinimumWidth = 6;
            this.time.Name = "time";
            this.time.Width = 50;
            // 
            // fightStatus
            // 
            this.fightStatus.HeaderText = "Статус";
            this.fightStatus.MinimumWidth = 6;
            this.fightStatus.Name = "fightStatus";
            this.fightStatus.Width = 50;
            // 
            // fightNumber
            // 
            this.fightNumber.HeaderText = "Номер в турнире";
            this.fightNumber.MinimumWidth = 6;
            this.fightNumber.Name = "fightNumber";
            this.fightNumber.Width = 60;
            // 
            // eventTab
            // 
            this.eventTab.Controls.Add(this.eventsGridView);
            this.eventTab.Location = new System.Drawing.Point(4, 25);
            this.eventTab.Name = "eventTab";
            this.eventTab.Padding = new System.Windows.Forms.Padding(3);
            this.eventTab.Size = new System.Drawing.Size(989, 420);
            this.eventTab.TabIndex = 1;
            this.eventTab.Text = "Турнир";
            this.eventTab.UseVisualStyleBackColor = true;
            // 
            // eventsGridView
            // 
            this.eventsGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.eventsGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.eventName,
            this.eventArena,
            this.eventDate,
            this.attend,
            this.sold,
            this.revenue,
            this.cash,
            this.costs,
            this.profit});
            this.eventsGridView.Location = new System.Drawing.Point(7, 6);
            this.eventsGridView.Name = "eventsGridView";
            this.eventsGridView.RowHeadersWidth = 51;
            this.eventsGridView.RowTemplate.Height = 24;
            this.eventsGridView.Size = new System.Drawing.Size(972, 408);
            this.eventsGridView.TabIndex = 0;
            // 
            // eventName
            // 
            this.eventName.HeaderText = "Название";
            this.eventName.MinimumWidth = 6;
            this.eventName.Name = "eventName";
            this.eventName.Width = 125;
            // 
            // eventArena
            // 
            this.eventArena.HeaderText = "Место проведения";
            this.eventArena.MinimumWidth = 6;
            this.eventArena.Name = "eventArena";
            this.eventArena.Width = 125;
            // 
            // eventDate
            // 
            this.eventDate.HeaderText = "Дата";
            this.eventDate.MinimumWidth = 6;
            this.eventDate.Name = "eventDate";
            this.eventDate.Width = 70;
            // 
            // attend
            // 
            this.attend.HeaderText = "Суммарная посещаемость (чел)";
            this.attend.MinimumWidth = 6;
            this.attend.Name = "attend";
            this.attend.Width = 125;
            // 
            // sold
            // 
            this.sold.HeaderText = "Продано билетов";
            this.sold.MinimumWidth = 6;
            this.sold.Name = "sold";
            this.sold.Width = 60;
            // 
            // revenue
            // 
            this.revenue.HeaderText = "Общая выручка (руб)";
            this.revenue.MinimumWidth = 6;
            this.revenue.Name = "revenue";
            this.revenue.Width = 125;
            // 
            // cash
            // 
            this.cash.HeaderText = "Кассовые сборы (руб)";
            this.cash.MinimumWidth = 6;
            this.cash.Name = "cash";
            this.cash.Width = 90;
            // 
            // costs
            // 
            this.costs.HeaderText = "Затраты на организацию (руб)";
            this.costs.MinimumWidth = 6;
            this.costs.Name = "costs";
            this.costs.Width = 90;
            // 
            // profit
            // 
            this.profit.HeaderText = "Профициты (руб)";
            this.profit.MinimumWidth = 6;
            this.profit.Name = "profit";
            this.profit.Width = 90;
            // 
            // fighterTab
            // 
            this.fighterTab.Controls.Add(this.fightersGridView);
            this.fighterTab.Location = new System.Drawing.Point(4, 25);
            this.fighterTab.Name = "fighterTab";
            this.fighterTab.Padding = new System.Windows.Forms.Padding(3);
            this.fighterTab.Size = new System.Drawing.Size(989, 420);
            this.fighterTab.TabIndex = 2;
            this.fighterTab.Text = "Боец";
            this.fighterTab.UseVisualStyleBackColor = true;
            // 
            // fightersGridView
            // 
            this.fightersGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.fightersGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.code,
            this.fio,
            this.birthDate,
            this.country,
            this.citizenship,
            this.seniority,
            this.signDate,
            this.endDate,
            this.phone,
            this.email,
            this.passport,
            this.address,
            this.wins,
            this.losses,
            this.weight,
            this.height,
            this.reach});
            this.fightersGridView.Location = new System.Drawing.Point(6, 6);
            this.fightersGridView.Name = "fightersGridView";
            this.fightersGridView.RowHeadersWidth = 51;
            this.fightersGridView.RowTemplate.Height = 24;
            this.fightersGridView.Size = new System.Drawing.Size(973, 408);
            this.fightersGridView.TabIndex = 0;
            // 
            // code
            // 
            this.code.HeaderText = "Код";
            this.code.MinimumWidth = 6;
            this.code.Name = "code";
            this.code.Width = 40;
            // 
            // fio
            // 
            this.fio.HeaderText = "ФИО";
            this.fio.MinimumWidth = 6;
            this.fio.Name = "fio";
            this.fio.Width = 150;
            // 
            // birthDate
            // 
            this.birthDate.HeaderText = "Дата рождения";
            this.birthDate.MinimumWidth = 6;
            this.birthDate.Name = "birthDate";
            this.birthDate.Width = 80;
            // 
            // country
            // 
            this.country.HeaderText = "Страна";
            this.country.MinimumWidth = 6;
            this.country.Name = "country";
            this.country.Width = 125;
            // 
            // citizenship
            // 
            this.citizenship.HeaderText = "Гражданство";
            this.citizenship.MinimumWidth = 6;
            this.citizenship.Name = "citizenship";
            this.citizenship.Width = 125;
            // 
            // seniority
            // 
            this.seniority.HeaderText = "Стаж";
            this.seniority.MinimumWidth = 6;
            this.seniority.Name = "seniority";
            this.seniority.Width = 40;
            // 
            // signDate
            // 
            this.signDate.HeaderText = "Дата подписания в организацию";
            this.signDate.MinimumWidth = 6;
            this.signDate.Name = "signDate";
            this.signDate.Width = 90;
            // 
            // endDate
            // 
            this.endDate.HeaderText = "Дата окончания контракта";
            this.endDate.MinimumWidth = 6;
            this.endDate.Name = "endDate";
            this.endDate.Width = 80;
            // 
            // phone
            // 
            this.phone.HeaderText = "Телефон";
            this.phone.MinimumWidth = 6;
            this.phone.Name = "phone";
            this.phone.Width = 110;
            // 
            // email
            // 
            this.email.HeaderText = "Электронная почта";
            this.email.MinimumWidth = 6;
            this.email.Name = "email";
            this.email.Width = 125;
            // 
            // passport
            // 
            this.passport.HeaderText = "Паспортные данные";
            this.passport.MinimumWidth = 6;
            this.passport.Name = "passport";
            this.passport.Width = 125;
            // 
            // address
            // 
            this.address.HeaderText = "Адрес";
            this.address.MinimumWidth = 6;
            this.address.Name = "address";
            this.address.Width = 125;
            // 
            // wins
            // 
            this.wins.HeaderText = "Победы";
            this.wins.MinimumWidth = 6;
            this.wins.Name = "wins";
            this.wins.Width = 60;
            // 
            // losses
            // 
            this.losses.HeaderText = "Поражения";
            this.losses.MinimumWidth = 6;
            this.losses.Name = "losses";
            this.losses.Width = 70;
            // 
            // weight
            // 
            this.weight.HeaderText = "Вес";
            this.weight.MinimumWidth = 6;
            this.weight.Name = "weight";
            this.weight.Width = 50;
            // 
            // height
            // 
            this.height.HeaderText = "Рост";
            this.height.MinimumWidth = 6;
            this.height.Name = "height";
            this.height.Width = 50;
            // 
            // reach
            // 
            this.reach.HeaderText = "Размах рук";
            this.reach.MinimumWidth = 6;
            this.reach.Name = "reach";
            this.reach.Width = 60;
            // 
            // insertButton
            // 
            this.insertButton.Location = new System.Drawing.Point(10, 10);
            this.insertButton.Name = "insertButton";
            this.insertButton.Size = new System.Drawing.Size(114, 64);
            this.insertButton.TabIndex = 1;
            this.insertButton.Text = "Добавить";
            this.insertButton.UseVisualStyleBackColor = true;
            this.insertButton.Click += new System.EventHandler(this.insertButton_Click);
            // 
            // updateButton
            // 
            this.updateButton.Location = new System.Drawing.Point(146, 10);
            this.updateButton.Name = "updateButton";
            this.updateButton.Size = new System.Drawing.Size(114, 64);
            this.updateButton.TabIndex = 2;
            this.updateButton.Text = "Изменить";
            this.updateButton.UseVisualStyleBackColor = true;
            this.updateButton.Click += new System.EventHandler(this.updateButton_Click);
            // 
            // deleteButton
            // 
            this.deleteButton.Location = new System.Drawing.Point(282, 10);
            this.deleteButton.Name = "deleteButton";
            this.deleteButton.Size = new System.Drawing.Size(114, 64);
            this.deleteButton.TabIndex = 3;
            this.deleteButton.Text = "Удалить";
            this.deleteButton.UseVisualStyleBackColor = true;
            this.deleteButton.Click += new System.EventHandler(this.deleteButton_Click);
            // 
            // buttonChamp
            // 
            this.buttonChamp.Location = new System.Drawing.Point(13, 10);
            this.buttonChamp.Name = "buttonChamp";
            this.buttonChamp.Size = new System.Drawing.Size(114, 64);
            this.buttonChamp.TabIndex = 4;
            this.buttonChamp.Text = "Список действующих чемпионов";
            this.buttonChamp.UseVisualStyleBackColor = true;
            this.buttonChamp.Click += new System.EventHandler(this.buttonChamp_Click);
            // 
            // buttonContracts
            // 
            this.buttonContracts.Location = new System.Drawing.Point(145, 10);
            this.buttonContracts.Name = "buttonContracts";
            this.buttonContracts.Size = new System.Drawing.Size(114, 64);
            this.buttonContracts.TabIndex = 5;
            this.buttonContracts.Text = "Список активных контрактов";
            this.buttonContracts.UseVisualStyleBackColor = true;
            this.buttonContracts.Click += new System.EventHandler(this.buttonContracts_Click);
            // 
            // buttonAwards
            // 
            this.buttonAwards.Location = new System.Drawing.Point(277, 10);
            this.buttonAwards.Name = "buttonAwards";
            this.buttonAwards.Size = new System.Drawing.Size(114, 64);
            this.buttonAwards.TabIndex = 6;
            this.buttonAwards.Text = "Награды за поединки";
            this.buttonAwards.UseVisualStyleBackColor = true;
            this.buttonAwards.Click += new System.EventHandler(this.buttonAwards_Click);
            // 
            // panelPromotion1
            // 
            this.panelPromotion1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panelPromotion1.Controls.Add(this.insertButton);
            this.panelPromotion1.Controls.Add(this.updateButton);
            this.panelPromotion1.Controls.Add(this.deleteButton);
            this.panelPromotion1.Location = new System.Drawing.Point(12, 467);
            this.panelPromotion1.Name = "panelPromotion1";
            this.panelPromotion1.Size = new System.Drawing.Size(409, 88);
            this.panelPromotion1.TabIndex = 7;
            // 
            // panelPromotion2
            // 
            this.panelPromotion2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panelPromotion2.Controls.Add(this.buttonAwards);
            this.panelPromotion2.Controls.Add(this.buttonChamp);
            this.panelPromotion2.Controls.Add(this.buttonContracts);
            this.panelPromotion2.Location = new System.Drawing.Point(441, 467);
            this.panelPromotion2.Name = "panelPromotion2";
            this.panelPromotion2.Size = new System.Drawing.Size(406, 88);
            this.panelPromotion2.TabIndex = 8;
            // 
            // panelPromotion3
            // 
            this.panelPromotion3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panelPromotion3.Controls.Add(this.buttonExit);
            this.panelPromotion3.Location = new System.Drawing.Point(866, 467);
            this.panelPromotion3.Name = "panelPromotion3";
            this.panelPromotion3.Size = new System.Drawing.Size(143, 88);
            this.panelPromotion3.TabIndex = 9;
            // 
            // buttonExit
            // 
            this.buttonExit.Location = new System.Drawing.Point(14, 10);
            this.buttonExit.Name = "buttonExit";
            this.buttonExit.Size = new System.Drawing.Size(114, 64);
            this.buttonExit.TabIndex = 9;
            this.buttonExit.Text = "Выход";
            this.buttonExit.UseVisualStyleBackColor = true;
            this.buttonExit.Click += new System.EventHandler(this.buttonExit_Click);
            // 
            // PromotionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1022, 567);
            this.Controls.Add(this.panelPromotion3);
            this.Controls.Add(this.promotionTabControl);
            this.Controls.Add(this.panelPromotion1);
            this.Controls.Add(this.panelPromotion2);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "PromotionForm";
            this.Text = "Промоушен";
            this.promotionTabControl.ResumeLayout(false);
            this.fightTab.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.fightGridView)).EndInit();
            this.eventTab.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.eventsGridView)).EndInit();
            this.fighterTab.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.fightersGridView)).EndInit();
            this.panelPromotion1.ResumeLayout(false);
            this.panelPromotion2.ResumeLayout(false);
            this.panelPromotion3.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl promotionTabControl;
        private System.Windows.Forms.TabPage fightTab;
        private System.Windows.Forms.TabPage eventTab;
        private System.Windows.Forms.TabPage fighterTab;
        private System.Windows.Forms.DataGridView fightersGridView;
        private System.Windows.Forms.Button insertButton;
        private System.Windows.Forms.Button updateButton;
        private System.Windows.Forms.Button deleteButton;
        private System.Windows.Forms.DataGridView fightGridView;
        private System.Windows.Forms.DataGridView eventsGridView;
        private System.Windows.Forms.Button buttonChamp;
        private System.Windows.Forms.Button buttonContracts;
        private System.Windows.Forms.Button buttonAwards;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightCode;
        private System.Windows.Forms.DataGridViewTextBoxColumn fio1;
        private System.Windows.Forms.DataGridViewTextBoxColumn fio2;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightEvent;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightWeight;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightWinner;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightResult;
        private System.Windows.Forms.DataGridViewTextBoxColumn round;
        private System.Windows.Forms.DataGridViewTextBoxColumn time;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightStatus;
        private System.Windows.Forms.DataGridViewTextBoxColumn fightNumber;
        private System.Windows.Forms.DataGridViewTextBoxColumn eventName;
        private System.Windows.Forms.DataGridViewTextBoxColumn eventArena;
        private System.Windows.Forms.DataGridViewTextBoxColumn eventDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn attend;
        private System.Windows.Forms.DataGridViewTextBoxColumn sold;
        private System.Windows.Forms.DataGridViewTextBoxColumn revenue;
        private System.Windows.Forms.DataGridViewTextBoxColumn cash;
        private System.Windows.Forms.DataGridViewTextBoxColumn costs;
        private System.Windows.Forms.DataGridViewTextBoxColumn profit;
        private System.Windows.Forms.DataGridViewTextBoxColumn code;
        private System.Windows.Forms.DataGridViewTextBoxColumn fio;
        private System.Windows.Forms.DataGridViewTextBoxColumn birthDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn country;
        private System.Windows.Forms.DataGridViewTextBoxColumn citizenship;
        private System.Windows.Forms.DataGridViewTextBoxColumn seniority;
        private System.Windows.Forms.DataGridViewTextBoxColumn signDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn endDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn phone;
        private System.Windows.Forms.DataGridViewTextBoxColumn email;
        private System.Windows.Forms.DataGridViewTextBoxColumn passport;
        private System.Windows.Forms.DataGridViewTextBoxColumn address;
        private System.Windows.Forms.DataGridViewTextBoxColumn wins;
        private System.Windows.Forms.DataGridViewTextBoxColumn losses;
        private System.Windows.Forms.DataGridViewTextBoxColumn weight;
        private System.Windows.Forms.DataGridViewTextBoxColumn height;
        private System.Windows.Forms.DataGridViewTextBoxColumn reach;
        private System.Windows.Forms.Panel panelPromotion1;
        private System.Windows.Forms.Panel panelPromotion2;
        private System.Windows.Forms.Panel panelPromotion3;
        private System.Windows.Forms.Button buttonExit;
    }
}

