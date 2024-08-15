using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Promotion
{
    public partial class PromotionForm : Form
    {
        private string connectionString = "Data Source=DESKMOBI\\SQLEXPRESS;Initial Catalog=Promotion;Integrated Security=True";
        private DbController dbController;

        public enum CurrentAction { Insert, Update, Delete }
        public delegate void InvokeOperationHandler();
        public InvokeOperationHandler InvokeInsertDialog;
        public InvokeOperationHandler InvokeUpdateDialog;
        public InvokeOperationHandler InvokeDelete;
        public PromotionForm()
        {
            InitializeComponent();
            dbController = new DbController(connectionString);
            InvokeInsertDialog = FightInsertDialog;
            InvokeUpdateDialog = FightUpdateDialog;
            InvokeDelete = DeleteFight;
            UpdateFightsGrid();
        }

        private void promotionTabControl_Selected(object sender, TabControlEventArgs e)
        {
            if (e.TabPage == fighterTab)
            {
                UpdateFightersGrid();
                InvokeInsertDialog = FighterInsertDialog;
                InvokeUpdateDialog = FighterUpdateDialog;
                InvokeDelete = DeleteFighter;
            }
            else if(e.TabPage == fightTab)
            {
                UpdateFightsGrid();
                InvokeInsertDialog = FightInsertDialog;
                InvokeUpdateDialog = FightUpdateDialog;
                InvokeDelete = DeleteFight;
            }
            else if(e.TabPage == eventTab)
            {
                UpdateEventsGrid();
                InvokeInsertDialog = EventInsertDialog;
                InvokeUpdateDialog = EventUpdateDialog;
                InvokeDelete = DeleteEvent;
            }
        }

        //Бойцы
        private void UpdateFightersGrid()
        {
            fightersGridView.Rows.Clear();
            List<Fighter> fighters = new List<Fighter>();
            try
            {
                fighters = dbController.GetFighters();
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка чтения данных о бойцах. Пожалуйста, проверьте подключение к серверу.\n" +
                    "Информация об ошибке: " + e.Message,
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            foreach (Fighter fighter in fighters)
            {
                fightersGridView.Rows.Add(fighter.Code, fighter.FIO, fighter.BirthDate, fighter.Country,
                    fighter.Citizenship, fighter.Seniority, fighter.SignDate, fighter.EndDate,
                    fighter.Phone, fighter.Email, fighter.Passport, fighter.Address, fighter.Wins,
                    fighter.Losses, fighter.Weight, fighter.Height, fighter.Reach);
            }
        }
        private void FighterInsertDialog()
        {
            FighterForm fighterForm = new FighterForm();
            fighterForm.dbController = dbController;
            fighterForm.EditableFighter = new Fighter();
            fighterForm.CurrentAction = CurrentAction.Insert;
            fighterForm.ShowDialog();
            UpdateFightersGrid();
        }
        private void FighterUpdateDialog()
        {
            if (fightersGridView.SelectedRows.Count > 0)
            {
                FighterForm fighterForm = new FighterForm();
                fighterForm.dbController = dbController;
                fighterForm.EditableFighter = new Fighter()
                {
                    FIO = fightersGridView.SelectedRows[0].Cells[1].Value.ToString(),
                    BirthDate = fightersGridView.SelectedRows[0].Cells[2].Value.ToString(),
                    Country = fightersGridView.SelectedRows[0].Cells[3].Value.ToString(),
                    Citizenship = fightersGridView.SelectedRows[0].Cells[4].Value.ToString(),
                    Seniority = (byte)fightersGridView.SelectedRows[0].Cells[5].Value,
                    Phone = fightersGridView.SelectedRows[0].Cells[8].Value.ToString(),
                    Email = fightersGridView.SelectedRows[0].Cells[9].Value.ToString(),
                    Passport = fightersGridView.SelectedRows[0].Cells[10].Value.ToString(),
                    Address = fightersGridView.SelectedRows[0].Cells[11].Value.ToString(),
                    Weight = (double)fightersGridView.SelectedRows[0].Cells[14].Value,
                    Height = (double)fightersGridView.SelectedRows[0].Cells[15].Value,
                    Reach = (double)fightersGridView.SelectedRows[0].Cells[16].Value
                };
                fighterForm.CurrentAction = CurrentAction.Update;
                fighterForm.Index = (int)fightersGridView.SelectedRows[0].Cells[0].Value;
                fighterForm.ShowDialog();
                UpdateFightersGrid();
            }
            else
                MessageBox.Show("Выберите запись для обновления", "Предупреждение", 
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }
        private void DeleteFighter()
        {
            if (fightersGridView.SelectedRows.Count > 0)
            {
                deleteForm deleteForm = new deleteForm();
                deleteForm.ShowDialog();
                if (deleteForm.DeleteAllow)
                {
                    try
                    {
                        foreach (DataGridViewRow item in fightersGridView.SelectedRows)
                            dbController.DeleteFighter((int)item.Cells[0].Value);
                        MessageBox.Show("Записи удалены", "Удаление", MessageBoxButtons.OK);
                    }
                    catch
                    {
                        MessageBox.Show("Ошибка удаления. Повторите попытку позже",
                            "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                UpdateFightersGrid();
            }
            else
                MessageBox.Show("Выберите запись для удаления", "Предупреждение",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        //Поединки
        private void UpdateFightsGrid()
        {
            fightGridView.Rows.Clear();
            List<Fight> fights = new List<Fight>();
            try
            {
                fights = dbController.GetFights();
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка чтения данных о поединках. Пожалуйста, проверьте подключение к серверу.\n" +
                    "Информация об ошибке: " + e.Message,
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            foreach (Fight fight in fights)
            {
                fightGridView.Rows.Add(fight.Code, fight.FIO1, fight.FIO2, fight.Tournament,
                    fight.Date, fight.Weight, fight.Winner, fight.Result, fight.Round,
                    fight.Time, fight.Status, fight.Number);
            }
        }
        private void FightInsertDialog()
        {
            FightForm fightForm = new FightForm();
            fightForm.dbController = dbController;
            fightForm.CurrentAction = CurrentAction.Insert;
            fightForm.EditableFight = new Fight();
            fightForm.ShowDialog();
            UpdateFightsGrid();
        }
        private void FightUpdateDialog()
        {
            if (fightGridView.SelectedRows.Count > 0)
            {
                FightForm fightForm = new FightForm();
                fightForm.dbController = dbController;
                fightForm.EditableFight = new Fight()
                {
                    Code = (int)fightGridView.SelectedRows[0].Cells[0].Value,
                    FIO1 = fightGridView.SelectedRows[0].Cells[1].Value.ToString(),
                    FIO2 = fightGridView.SelectedRows[0].Cells[2].Value.ToString(),
                    Tournament = fightGridView.SelectedRows[0].Cells[3].Value.ToString(),
                    Weight = fightGridView.SelectedRows[0].Cells[5].Value.ToString(),
                    Winner = fightGridView.SelectedRows[0].Cells[6].Value.ToString(),
                    Result = fightGridView.SelectedRows[0].Cells[7].Value.ToString(),
                    Round = (byte?)fightGridView.SelectedRows[0].Cells[8].Value,
                    Time = fightGridView.SelectedRows[0].Cells[9].Value.ToString(),
                    Status = (string)fightGridView.SelectedRows[0].Cells[10].Value,
                    Number = (byte?)fightGridView.SelectedRows[0].Cells[11].Value,
                };
                fightForm.CurrentAction = CurrentAction.Update;
                fightForm.ShowDialog();
                UpdateFightsGrid();
            }
            else
                MessageBox.Show("Выберите запись для обновления", "Предупреждение",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }
        private void DeleteFight()
        {
            if (fightGridView.SelectedRows.Count > 0)
            {
                deleteForm deleteForm = new deleteForm();
                deleteForm.ShowDialog();
                if (deleteForm.DeleteAllow)
                {
                    try
                    {
                        foreach (DataGridViewRow item in fightGridView.SelectedRows)
                            dbController.DeleteFight((int)item.Cells[0].Value);
                        MessageBox.Show("Записи удалены", "Удаление", MessageBoxButtons.OK);
                    }
                    catch
                    {
                        MessageBox.Show("Ошибка удаления. Повторите попытку позже",
                            "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                UpdateFightsGrid();
            }
            else
                MessageBox.Show("Выберите запись для удаления", "Предупреждение",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        //Турниры
        private void UpdateEventsGrid()
        {
            eventsGridView.Rows.Clear();
            List<Tournament> events = new List<Tournament>();
            try
            {
                events = dbController.GetEvents();
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка чтения данных о турнирах. Пожалуйста, проверьте подключение к серверу.\n" +
                    "Информация об ошибке: " + e.ToString(),
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            foreach (Tournament tour in events)
            {
                eventsGridView.Rows.Add(tour.Name, tour.Arena, tour.Date, tour.Attend, tour.Sold,
                    tour.Revenue, tour.Cash, tour.Costs, tour.Profit);
            }
        }
        private void EventInsertDialog()
        {
            EventForm eventForm = new EventForm();
            eventForm.dbController = dbController;
            eventForm.EditableEvent = new Tournament();
            eventForm.CurrentAction = CurrentAction.Insert;
            eventForm.ShowDialog();
            UpdateEventsGrid();
        }
        private void EventUpdateDialog()
        {
            if (eventsGridView.SelectedRows.Count > 0)
            {
                EventForm eventForm = new EventForm();
                eventForm.dbController = dbController;
                eventForm.EditableEvent = new Tournament()
                {
                    Name = eventsGridView.SelectedRows[0].Cells[0].Value.ToString(),
                    Arena = eventsGridView.SelectedRows[0].Cells[1].Value.ToString(),
                    Date = eventsGridView.SelectedRows[0].Cells[2].Value.ToString(),
                    Attend = (int?)eventsGridView.SelectedRows[0].Cells[3].Value,
                    Revenue = (decimal?)eventsGridView.SelectedRows[0].Cells[5].Value,
                    Costs = (decimal?)eventsGridView.SelectedRows[0].Cells[7].Value
                };
                eventForm.CurrentAction = CurrentAction.Update;
                eventForm.ShowDialog();
                UpdateEventsGrid();
            }
            else
                MessageBox.Show("Выберите запись для обновления", "Предупреждение",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }
        private void DeleteEvent()
        {
            if (eventsGridView.SelectedRows.Count > 0)
            {
                deleteForm deleteForm = new deleteForm();
                deleteForm.ShowDialog();
                if (deleteForm.DeleteAllow)
                {
                    try
                    {
                        foreach (DataGridViewRow item in eventsGridView.SelectedRows)
                            dbController.DeleteEvent(item.Cells[0].Value.ToString());
                        MessageBox.Show("Записи удалены", "Удаление", MessageBoxButtons.OK);
                    }
                    catch
                    {
                        MessageBox.Show("Ошибка удаления. Повторите попытку позже",
                            "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
                UpdateEventsGrid();
            }
            else
                MessageBox.Show("Выберите запись для удаления", "Предупреждение",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void insertButton_Click(object sender, EventArgs e)
        {
            InvokeInsertDialog();
        }

        private void updateButton_Click(object sender, EventArgs e)
        {
            InvokeUpdateDialog();
        }

        private void deleteButton_Click(object sender, EventArgs e)
        {
            InvokeDelete();
        }

        //Представления
        private void ChampDialog()
        {
            ChampForm champForm = new ChampForm();
            champForm.dbController = dbController;
            champForm.ShowDialog();
        }

        private void buttonChamp_Click(object sender, EventArgs e)
        {
            ChampDialog();
        }

        private void ContractDialog()
        {
            ContractForm contractForm = new ContractForm();
            contractForm.dbController = dbController;
            contractForm.ShowDialog();
        }

        private void buttonContracts_Click(object sender, EventArgs e)
        {
            ContractDialog();
        }

        private void AwardDialog()
        {
            AwardsForm awardsForm = new AwardsForm();
            awardsForm.dbController = dbController;
            awardsForm.ShowDialog();
        }

        private void buttonAwards_Click(object sender, EventArgs e)
        {
            AwardDialog();
        }

        private void buttonExit_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}