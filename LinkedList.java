public class LinkedList {
    Node head;

    public void insert(int data){
        // System.out.println(head);
        Node node =new Node();
        node.data = data;
        node.next = null;
        //System.out.println(" my node " + head.data);
        if(head == null){
            head = node;
        

        }
        else{
            Node n = head;
            //System.out.println("my n next " + n.next);
            while(n.next != null)
            {
                //System.out.println("new n " + n.next);
                
                n = n.next;
                System.out.println(" data part "+ n.next);
            }
            n.next = node;

            //System.out.println("mynode" + node.next);
        }
    }
    public void insertAtstart(int data){
        Node node =new Node();
        node.data = data;
        node.next = null;
        node.next = head;

        head = node;
    }
    public void insertAt(int index,int data){
        Node node =new Node();
        node.data = data;
        node.next = null;

        if(index == 0)
        {
            insertAtstart(data);
        }
        else
        {Node n = head;
        for(int i =0;i<index;i++){
            n = n.next;
        }
        node.next = n.next;
        n.next = node;
    }



}
public void deleteAt(int index){
    if(index == 0)
    {
        head = head.next;
    }
    else{
        Node n =head;
        Node n1 = null;

        for(int i =0;i<index-1;i++){
            n = n.next;
        }
        n1 = n.next;
        n.next = n1.next;
       System.out.println("n1 " + n1.data);
    }
}
    public void show()
    {
        Node node = head;

        while(node.next != null)
        {
           System.out.println(node.data);

            node = node.next;
        }
       System.out.println(node.data);
    }
}
