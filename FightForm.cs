using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Promotion
{
    public partial class FightForm : Form
    {
        private List<Fighter> fioBox = new List<Fighter>();
        private List<Tournament> tourBox = new List<Tournament>();
        private List<string> weightBox = new List<string>();
        private List<string> resultBox = new List<string>();
        
        public DbController dbController;
        public PromotionForm.CurrentAction CurrentAction;
        public Fight EditableFight { get; set; }
        public FightForm()
        {
            InitializeComponent();
        }
        private void FillComboBoxes()
        {
            fioBox = dbController.GetFighters();
            tourBox = dbController.GetEvents();
            weightBox = dbController.GetWeights();
            resultBox = dbController.GetResults();

            fio1ComboBox.Items.Clear();
            fio2ComboBox.Items.Clear();
            foreach (var item in fioBox)
            {
                fio1ComboBox.Items.Add(item.FIO);
                fio2ComboBox.Items.Add(item.FIO);
            }
            comboBoxEvent.Items.Clear();
            foreach (var item in tourBox)
            {
                comboBoxEvent.Items.Add(item.Name);
            }
            comboBoxWeight.Items.Clear();
            foreach (var item in weightBox)
            {
                comboBoxWeight.Items.Add(item);
            }
            comboBoxResult.Items.Clear();
            foreach (var item in resultBox)
            {
                comboBoxResult.Items.Add(item);
            }
            comboBoxWinner.Items.Clear();
            comboBoxWinner.Items.Add("1");
            comboBoxWinner.Items.Add("2");
            comboBoxWinner.Items.Add("Без победителя");

            if (CurrentAction == PromotionForm.CurrentAction.Update)
                checkBoxChamp.Checked = EditableFight.Status == "Ч" ?true:false;
        }

        private void FightForm_Load(object sender, EventArgs e)
        {
            FillComboBoxes();
            fio1ComboBox.Text = EditableFight.FIO1 == null? null: fioBox.Find(x => x.FIO == EditableFight.FIO1).FIO;
            fio2ComboBox.Text = EditableFight.FIO2 == null ? null : fioBox.Find(x => x.FIO == EditableFight.FIO2).FIO;
            comboBoxEvent.Text = EditableFight.Tournament == null ? null : tourBox.Find(x => x.Name == EditableFight.Tournament).Name;
            comboBoxWeight.Text = weightBox.Find(x => x == EditableFight.Weight);
            numericUpDownEventNumber.Text = (EditableFight.Number == null ? 
                null : EditableFight.Number).ToString();
            comboBoxWinner.Text = (string)(string.IsNullOrEmpty(EditableFight.Winner) ? comboBoxWinner.Items[2] :
                (EditableFight.Winner == EditableFight.FIO1 ? comboBoxWinner.Items[0] : 
                comboBoxWinner.Items[1]));
            comboBoxResult.Text = EditableFight.Result == null ? null : EditableFight.Result;
            numericUpDownRound.Text = (EditableFight.Round == null ? null : EditableFight.Round).ToString();
            textBoxTime.Text = EditableFight.Time == null ? null : EditableFight.Time;
        }

        private void buttonFightSend_Click(object sender, EventArgs e)
        {
            if (CurrentAction == PromotionForm.CurrentAction.Insert)
            {
                try
                {
                    dbController.InsertFight(fio1ComboBox.Text, fio2ComboBox.Text,
                        comboBoxEvent.Text, comboBoxWeight.Text,
                        !checkBoxResult.Checked ? null : comboBoxWinner.Text == 
                            "Без победителя" ? null : (comboBoxWinner.Text == "1" ?
                            fio1ComboBox.Text : fio2ComboBox.Text),
                        !checkBoxResult.Checked ? null : comboBoxResult.Text, 
                        Convert.ToByte(numericUpDownRound.Value),
                        !checkBoxResult.Checked ? null : textBoxTime.Text, checkBoxChamp.Checked ?
                        'Ч' : 'Н', string.IsNullOrEmpty(numericUpDownEventNumber.Text) ? null :
                            (byte?)numericUpDownEventNumber.Value);
                    Close();
                }
                catch
                {
                    MessageBox.Show("При вставке данных произошла ошибка. Проверьте корректность" +
                        " введенных данных.", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else
            {
                try
                {
                    dbController.UpdateFight(EditableFight.Code, fio1ComboBox.Text, fio2ComboBox.Text,
                        comboBoxEvent.Text, comboBoxWeight.Text,
                        !checkBoxResult.Checked ? null : comboBoxWinner.Text ==
                            "Без победителя" ? null : (comboBoxWinner.Text == "1" ?
                            fio1ComboBox.Text : fio2ComboBox.Text),
                        !checkBoxResult.Checked ? null : comboBoxResult.Text,
                        Convert.ToByte(numericUpDownRound.Value),
                        !checkBoxResult.Checked ? null : textBoxTime.Text, checkBoxChamp.Checked ?
                        'Ч' : 'Н', string.IsNullOrEmpty(numericUpDownEventNumber.Text) ? null :
                            (byte?)numericUpDownEventNumber.Value);
                    Close();
                }
                catch
                {
                    MessageBox.Show("При обновлении данных произошла ошибка. Проверьте корректность" +
                        " введенных данных.", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void buttonFightCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void checkBoxResult_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBoxResult.Checked == false)
            {
                comboBoxWinner.Enabled = false;
                comboBoxResult.Enabled = false;
                numericUpDownRound.Enabled = false;
                textBoxTime.Enabled = false;
            }
            if(checkBoxResult.Checked == true)
            {
                comboBoxWinner.Enabled = true;
                comboBoxResult.Enabled = true;
                numericUpDownRound.Enabled = true;
                textBoxTime.Enabled = true;
            }
        }
    }
}
