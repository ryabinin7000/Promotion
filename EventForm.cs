using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Promotion
{
    public partial class EventForm : Form
    {
        public DbController dbController;
        public PromotionForm.CurrentAction CurrentAction;
        public Tournament EditableEvent;
        private List<string> arenaBox = new List<string>();
        public EventForm()
        {
            InitializeComponent();
        }
        private void FillComboBox()
        {
            arenaBox = dbController.GetArenas();
            comboBoxArenas.Items.Clear();
            foreach (var item in arenaBox)
            {
                comboBoxArenas.Items.Add(item);
            }
        }

        private void EventForm_Load(object sender, EventArgs e)
        {
            FillComboBox();
            textBoxName.Text = EditableEvent.Name;
            dateTimePickerEvent.Value = EditableEvent.Date == null ?
                dateTimePickerEvent.Value : Convert.ToDateTime(EditableEvent.Date);
            comboBoxArenas.Text = arenaBox.Find(x => x == EditableEvent.Arena);
            textBoxAttend.Text = EditableEvent.Attend.ToString();
            textBoxRevenue.Text = EditableEvent.Revenue.ToString();
            textBoxCosts.Text = EditableEvent.Costs.ToString();
            if (CurrentAction != PromotionForm.CurrentAction.Insert)
            {
                textBoxName.Enabled = false;
            }
        }

        private void buttonEventCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void buttonEventSend_Click(object sender, EventArgs e)
        {
            if (CurrentAction == PromotionForm.CurrentAction.Insert)
            {
                try
                {
                    dbController.InsertEvent(textBoxName.Text, comboBoxArenas.Text.ToString(),
                        dateTimePickerEvent.Value.ToString(),
                        string.IsNullOrEmpty(textBoxAttend.Text) ? 0 : Convert.ToInt16(textBoxAttend.Text),
                        string.IsNullOrEmpty(textBoxRevenue.Text) ? 0 : Convert.ToDecimal(textBoxRevenue.Text),
                        string.IsNullOrEmpty(textBoxCosts.Text) ? 0 : Convert.ToDecimal(textBoxCosts.Text));
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
                    dbController.UpdateEvent(textBoxName.Text, comboBoxArenas.Text.ToString(),
                        dateTimePickerEvent.Value.ToString(),
                        string.IsNullOrEmpty(textBoxAttend.Text) ? 0 : Convert.ToInt16(textBoxAttend.Text),
                        string.IsNullOrEmpty(textBoxRevenue.Text) ? 0 : Convert.ToDecimal(textBoxRevenue.Text),
                        string.IsNullOrEmpty(textBoxCosts.Text) ? 0 : Convert.ToDecimal(textBoxCosts.Text));
                    Close();
                }
                catch
                {
                    MessageBox.Show("При обновлении данных произошла ошибка. Проверьте корректность" +
                        " введенных данных.", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    }
}
