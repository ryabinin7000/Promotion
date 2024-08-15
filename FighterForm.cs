using System;
using System.Windows.Forms;

namespace Promotion
{
    public partial class FighterForm : Form
    {
        public DbController dbController;
        public Fighter EditableFighter { get; set; }
        public PromotionForm.CurrentAction CurrentAction;
        public int Index { get; set; }
        public FighterForm()
        {
            InitializeComponent();
        }
        private void FighterForm_Load(object sender, EventArgs e)
        {
            textBoxFio.Text = EditableFighter.FIO;
            textBoxCountry.Text = EditableFighter.Country;
            textBoxPhone.Text = EditableFighter.Phone;
            textBoxEmail.Text = EditableFighter.Email;
            textBoxAddress.Text = EditableFighter.Address;
            textBoxCitizenship.Text = EditableFighter.Citizenship;
            textBoxPassport.Text = EditableFighter.Passport;
            textBoxWeight.Text = EditableFighter.Weight.ToString();
            textBoxHeight.Text = EditableFighter.Height.ToString();
            textBoxReach.Text = EditableFighter.Reach.ToString();
            numericUpDownSeniority.Value = EditableFighter.Seniority;
            dateTimePickerFighter.Value = EditableFighter.BirthDate == null?
                dateTimePickerFighter.Value:Convert.ToDateTime(EditableFighter.BirthDate);
        }
        private void buttonSubmitFighter_Click(object sender, EventArgs e)
        {
            if(CurrentAction == PromotionForm.CurrentAction.Insert)
            {
                try
                {
                    dbController.InsertFighter(textBoxFio.Text, dateTimePickerFighter.Value.ToString(),
                    textBoxCountry.Text, textBoxCitizenship.Text, Convert.ToByte(numericUpDownSeniority.Value),
                    textBoxPhone.Text, textBoxEmail.Text, textBoxPassport.Text, textBoxAddress.Text,
                    Convert.ToSingle(textBoxWeight.Text), Convert.ToSingle(textBoxHeight.Text),
                    Convert.ToSingle(textBoxReach.Text));
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
                    dbController.UpdateFighter(Index, textBoxFio.Text, dateTimePickerFighter.Value.ToString(),
                    textBoxCountry.Text, textBoxCitizenship.Text, Convert.ToByte(numericUpDownSeniority.Value),
                    textBoxPhone.Text, textBoxEmail.Text, textBoxPassport.Text, textBoxAddress.Text,
                    Convert.ToSingle(textBoxWeight.Text), Convert.ToSingle(textBoxHeight.Text),
                    Convert.ToSingle(textBoxReach.Text));
                    Close();
                }
                catch
                {
                    MessageBox.Show("При обновлении данных произошла ошибка. Проверьте корректность" +
                        " введенных данных.", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void buttonCancelFighter_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
